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
          response.merge!({status: 'renderReady',job_id: rand(200)})
        when 'renderTime'
          #respond with the job's current background status
          response.merge!({status: job_is_complete(params[:job_id]) ? "done" : "working",time: 12})
        else
          response = {status: 'Command Not Recognized'}
        end
    else
      response = {status: 'Query is empty'}
    end
    render json: response
  end

  def renderCommand
    response = {}
    if(params[:command])
      case params[:command]
        when 'grabVideos'
          response.merge!({status: grabVidURLs(params[:urls]) ? 'videosDownloaded' : 'downloadFailed'})
        when 'grabPhotos'
          response.merge!({status: grabVidURLs(params[:urls]) ? 'photosDownloaded' : 'downloadFailed'})
        when 'startVideoRender'
          response.merge!({status: 'renderVideoStart',job_id: rand(200)})
          job_id = RenderWorker.perform_async(current_user.id,session[:videos],'movie')
          RenderQueue.create(user_id: current_user.id, job_id: job_id)
          puts "Starting Render on job_id: #{job_id}"
          response.merge!({status: 'renderVideoFinished',job_id: job_id})
        when 'startPhotoRender'
          response.merge!({status: 'renderPhotoStart',job_id: rand(200)})
          job_id = RenderWorker.perform_async(current_user.id,session[:photos],'slideshow')
          RenderQueue.create(user_id: current_user.id, job_id: job_id)
          puts "Starting Render on job_id: #{job_id}"
          response.merge!({status: 'renderPhotoFinished',job_id: job_id})
        when 'stopRender'
          puts "Stopping Render on job_id: #{params[:slot]}"
          response.merge!({status: 'renderStop',job_id: rand(200)})
        when 'verbocity'
          dir = params[:direction]
          if dir == "+"
            puts "Increasing Verbocity"
            response.merge!({status: 'verbChange',level: 0})
          elsif dir == "-"
            puts "Decreasing Verbocity"
            response.merge!({status: 'verbChange',level: 0})
          end
        else
          response = {status: 'Command Not Recognized'}
        end
    else
      response = {status: 'Query is empty'}
    end
    render json: response
  end

private

  def grabVidURLs(urls)
    return false if (urls.nil? || urls.empty?)
    movie_files = Array.new
    urls.map do |url|
      movie_files << url[-12..-1]
      save_dir = "public/data/#{movie_files[-1]}";
      open(save_dir,"wb") do |file|
        file.write open(url).read
      end
    end
    session[:videos] = movie_files
    return true
  end

  def grabPicURLs(urls)
    return false if (urls.nil? || urls.empty?)
    photo_files = Array.new
    urls.map do |url|
      photo_files << url[-12..-1]
      save_dir = "public/data/img#{photo_files[-1]}";
      open(save_dir,"wb") do |file|
        file.write open(url).read
      end
    end
    session[:photos] = photo_files
    return true
  end

  def returnUserJobs(user)
    user_found = RenderQueue.where(user_id: user).all
    #unless user_found.nil? return user_found.map{|index| index.job_id}
  end

end
