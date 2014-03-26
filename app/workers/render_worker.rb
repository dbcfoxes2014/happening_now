class RenderWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id,urls,type)
    if(type == 'movie')
      grabVidURLs(user_id,urls)
    elsif(type == 'slideshow')
      grabPicURLs(user_id,urls)
    end
  end

  private

  def grabVidURLs(user_id,urls)
    movie_files = Array.new
    urls.map do |url|
      movie_files << url[-12..-1]
      save_dir = "public/data/#{movie_files[-1]}";
      open(save_dir,"wb") do |file|
        file.write open(url).read
      end
    end
    RenderQueue.where(user_id: user_id, job_id: jid).update_attributes({stage: 'rendering_video'})
    renderMovies(user_id,movie_files)
  end

  def grabPicURLs(user_id,urls)
    photo_files = Array.new
    urls.each_with_index.map do |url,index|
      index = "0#{index}" if index < 10
      photo_files << "img#{current_user.id}_#{index}.jpg"
      save_dir = "public/data/#{photo_files[-1]}";
      open(save_dir,"wb") do |file|
        file.write open(url).read
      end
    end
    RenderQueue.where(user_id: user_id, job_id: jid).update_attributes({stage: 'rendering_slideshow'})
    renderPhotos(user_id,photo_files)
  end

  def renderMovies(user_id,videos)
    movie_ffmpeg = Array.new
    #concate movies via transcoding
    videos.map do |mov|
      movie_ffmpeg << FFMPEG::Movie.new("public/data/#{mov}")
    end
    args = movie_ffmpeg[1..-1].map{ |mov| "-i " + mov.path }.join(" ")
    puts "Command: #{args}"
    #if(movie_ffmpeg.empty?)

    movie_name = nil
    if (Video.all.length == 0)
      movie_name = "data/1.mp4"
      screenshot_name = "data/1.jpg"
    else
      movie_name = "data/#{Video.last.id + 1}.mp4"
      screenshot_name = "data/#{Video.last.id + 1}.jpg"
    end

    movie_ffmpeg[0].transcode(
        "public/#{movie_name}",
        "#{args} -s 640x640 -filter_complex concat=n=#{movie_ffmpeg.size}:v=1:a=1 -threads 4 -strict -2",
        'movie'
    ){ |progress| puts "RENDERING://///#{progress}/////" }

    movie_ffmpeg[0].screenshot("public/#{screenshot_name}", seek_time: 5, resolution: '256x256')

    RenderQueue.where(job_id: jid).first.destroy;
    puts "Removed Job #{jid} from queue table!"

    Video.create(user_id: user_id, title: "we shouldnt have a title", file_path: "#{movie_name}", thumbnail_path: "#{screenshot_name}").save
  end

  def renderPhotos(user_id,slides)
    #puts "JID #{jid} - TID #{Thread.current.object_id.to_s}"
    #concate movies via transcoding
    photo_ffmpeg = FFMPEG::Movie.new("public/data/img#{user_id}_%02d.jpg")
    #if(movie_ffmpeg.empty?)

    slideshow_name = nil
    if (Video.all.length == 0)
      slidheshow_name = "data/img1.mp4"
      thumbnail_name  = "data/thumb1.jpg"
    else
      slideshow_name = "data/img#{Video.last.id + 1}.mp4"
      thumbnail_name = "data/thumb#{Video.last.id + 1}.jpg"
    end
    #works on terminal
    #ffmpeg -r 1/5 -pattern_type glob -i 'public/data/*.jpg' -c:v libx264 public/data/out.mp4
    #ffmpeg -i 'public/data/img2cd06c_8.jpg' -i public/data/img670ba3_8.jpg -filter_complex concat=n=2:v=1:a=0 -r 1/5 -c:v libx264 public/data/out.mp4
    photo_ffmpeg.transcode(
        "public/#{slideshow_name}",
        'slideshow'
    )

    RenderQueue.where(job_id: jid).first.destroy;
    puts "Removed Job #{jid} from queue table!"
    #photo_ffmpeg[0].screenshot("public/#{thumbnail_name}", seek_time: 5, resolution: '256x256')

    Video.create(user_id: user_id, title: "we shouldnt have a title", file_path: "#{slideshow_name}", thumbnail_path: "#{thumbnail_name}").save
  end
end
