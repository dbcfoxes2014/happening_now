class EditorController < ApplicationController
  def video
    if(current_user)
        @session_table = FlaggedContents.where(user_id: current_user.id)
    end
  end

  def photo

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
          grabURLs(params[:urls])
          response.merge!({status: 'videosDownloaded'})
        when 'startRender'
          puts "Starting Render on slot: #{params[:slot]}"
          response.merge!({status: 'renderStart',slot: rand(200)})
          renderMovies()
          response.merge!({status: 'renderFinished',slot: rand(200)})
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

  def grabURLs(urls)
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
    args = movie_ffmpeg[1..-1].map{ |mov| "-i '" + mov.path + "'" }.join(" ")
    puts "Command: #{args}"
    #if(movie_ffmpeg.empty?)

    movie_name = nil
    if (Video.all.length == 0)
      movie_name = "data/1.mp4"
      screenshot_name = "data/1.bmp"
    else
      movie_name = "data/#{Video.last.id + 1}.mp4"
      screenshot_name = "data/#{Video.last.id + 1}.bmp"
    end

    movie_ffmpeg[0].transcode(
        "public/#{movie_name}",
        "#{args} -s 480x480 -filter_complex concat=n=#{movie_ffmpeg.size}:v=1:a=1 -threads 4 -strict -2 -y"
    )

    movie_ffmpeg[0].screenshot("public/#{screenshot_name}", seek_time: 5, resolution: '480x480')

    Video.create(user_id: current_user.id, title: "we shouldnt have a title", file_path: "#{movie_name}", thumbnail_path: "#{screenshot_name}").save
  end
end
