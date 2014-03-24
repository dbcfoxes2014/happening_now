class EditorController < ApplicationController
  def video
    if(current_user)
        @session_table = FlaggedContent.where(user_id: current_user.id)
    end
  end

  def photo
    if(current_user)
        @session_table = FlaggedContent.where(user_id: current_user.id)
    end
  end

  def renderStatus
    response = {}
    if(params[:query])
      case params[:query]
        when 'slotAvaliable'
          response.merge!({status: 'renderReady',slot: rand(200)})
        when 'renderTime'
          response.merge!({status: 'renderTime',time: 12})
        else

        end
    else
      response = {status: 'Command Not Recognized'}
    end
    render json: response
  end

  def renderCommand
    response = {}
    if(params[:command])
      case params[:command]
        when 'grabVideos'
          p params[:urls]
          grabVidURLs(params[:urls])
          response.merge!({status: 'videosDownloaded'})
        when 'grabPhotos'
          p params[:urls]
          grabPicURLs(params[:urls])
          response.merge!({status: 'photosDownloaded'})
        when 'startVideoRender'
          puts "Starting Render on slot: #{params[:slot]}"
          response.merge!({status: 'renderVideoStart',slot: rand(200)})
          renderMovies()
          response.merge!({status: 'renderVideoFinished',slot: rand(200)})
        when 'startPhotoRender'
          puts "Starting Render on slot: #{params[:slot]}"
          response.merge!({status: 'renderPhotoStart',slot: rand(200)})
          renderPhotos()
          response.merge!({status: 'renderPhotoFinished',slot: rand(200)})
        when 'stopRender'
          puts "Stopping Render on slot: #{params[:slot]}"
          response.merge!({status: 'renderStop',slot: rand(200)})
        when 'verbocity'
          dir = params[:direction]
          if dir == "+"
            puts "Increasing Verbocity"
            response.merge!({status: 'verbChange',level: 0})
          elsif dir == "-"
            puts "Decreasing Verbocity"
            response.merge!({status: 'verbChange',level: 0})
          end
        end
    else
      response = {status: 'Command Not Recognized'}
    end
    render json: response
  end

private

  def grabVidURLs(urls)
    movie_files = Array.new
    urls.map do |url|
      movie_files << url[-12..-1]
      save_dir = "public/data/#{movie_files[-1]}";
      open(save_dir,"wb") do |file|
        file.write open(url).read
      end
    end
    session[:videos] = movie_files
  end

  def renderMovies
    movie_ffmpeg = Array.new
    #concate movies via transcoding
    session[:videos].map do |mov|
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
        "#{args} -s 640x640 -filter_complex concat=n=#{movie_ffmpeg.size}:v=1:a=1 -threads 4 -strict -2"
    )

    movie_ffmpeg[0].screenshot("public/#{screenshot_name}", seek_time: 5, resolution: '256x256')

    Video.create(user_id: current_user.id, title: "we shouldnt have a title", file_path: "#{movie_name}", thumbnail_path: "#{screenshot_name}").save
  end

  def grabPicURLs(urls)
    photo_files = Array.new
    urls.map do |url|
      photo_files << url[-12..-1]
      save_dir = "public/data/img#{photo_files[-1]}";
      open(save_dir,"wb") do |file|
        file.write open(url).read
      end
    end
    session[:photos] = photo_files
  end

  def renderPhotos
    photo_ffmpeg = Array.new
    #concate movies via transcoding
    session[:photos].map do |pic|
      photo_ffmpeg << FFMPEG::Movie.new("public/data/img#{pic}")
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
        "#{args} -filter_complex concat=n=#{photo_ffmpeg.size}:v=1:a=0 -r 1/5"
    )

    photo_ffmpeg[0].screenshot("public/#{thumbnail_name}", seek_time: 5, resolution: '256x256')

    Video.create(user_id: current_user.id, title: "we shouldnt have a title", file_path: "#{slideshow_name}", thumbnail_path: "#{thumbnail_name}").save
  end
end
