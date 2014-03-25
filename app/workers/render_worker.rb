class RenderWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(clips,type)
    puts "starting job #{type}"
    if(type == 'movie')
      renderMovies(clips)
    elsif(type == 'slideshow')
      renderPhotos(clips)
    end
  end

  private

  def renderMovies(videos)
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
    puts "rendering movie"
    movie_ffmpeg[0].transcode(
        "public/#{movie_name}",
        "#{args} -s 640x640 -filter_complex concat=n=#{movie_ffmpeg.size}:v=1:a=1 -threads 4 -strict -2",
        'movie'
    )

    movie_ffmpeg[0].screenshot("public/#{screenshot_name}", seek_time: 5, resolution: '256x256')


    #Video.create(user_id: current_user.id, title: "we shouldnt have a title", file_path: "#{movie_name}", thumbnail_path: "#{screenshot_name}").save
  end

  def renderPhotos(slides)
    photo_ffmpeg = Array.new
    #concate movies via transcoding
    slides.map do |pic|
      photo_ffmpeg << FFMPEG::Movie.new("public/data/*.jpg")
    end
    args = photo_ffmpeg[1..-1].map{ |pic| "-i " + pic.path }.join(" ")
    #if(movie_ffmpeg.empty?)

    slideshow_name = nil
    if (Video.all.length == 0)
      slidheshow_name = "data/img1.mp4"
      thumbnail_name = "data/thumb1.jpg"
    else
      slideshow_name = "data/img#{Video.last.id + 1}.mp4"
      thumbnail_name = "data/thumb#{Video.last.id + 1}.jpg"
    end
    puts "Command: #{args} -filter_complex concat=n=#{photo_ffmpeg.size}:v=1:a=0 -r 1/5"
    #works on terminal
    #ffmpeg -r 1/5 -pattern_type glob -i 'public/data/*.jpg' -c:v libx264 public/data/out.mp4
    #ffmpeg -i 'public/data/img2cd06c_8.jpg' -i public/data/img670ba3_8.jpg -filter_complex concat=n=2:v=1:a=0 -r 1/5 -c:v libx264 public/data/out.mp4
    photo_ffmpeg[0].transcode(
        "public/#{slideshow_name}",
        "#{args} -filter_complex concat=n=#{photo_ffmpeg.size}:v=1:a=0 -r 1/5",
        'slideshow'

    )
    #RenderQueue.where(job_id: )
    #photo_ffmpeg[0].screenshot("public/#{thumbnail_name}", seek_time: 5, resolution: '256x256')

    #Video.create(user_id: , title: "we shouldnt have a title", file_path: "#{slideshow_name}", thumbnail_path: "#{thumbnail_name}").save
  end
end
