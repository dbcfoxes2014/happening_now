class EditorController < ApplicationController
  include RenderHelper

  def video
    if(current_user)
        @session_table = FlaggedContent.where(user_id: current_user.id, extension: 'mp4')
    end
  end

  def photo
    if(current_user)
        @session_table = FlaggedContent.where(user_id: current_user.id, extension: 'jpg')
    end
  end

  def renderStatus
    response = {}
    if(params[:query])
      case params[:query]
        when 'slotAvaliable'
          response.merge!({status: 'renderReady'})
        when 'renderState'
          p "RENDER STATE HIT "
          #respond with the job's current background status
          response.merge!({status: job_current_state(params[:job_id])})
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
    if(params[:command] && !current_user.nil?)
      case params[:command]
        when 'grabVideos'
          if params[:urls].nil? || params[:urls].empty?
            response = {status: 'emptyList'}
          else
            job_id = RenderWorker.perform_async(current_user.id,params[:urls],'movie')
            project_title = params[:project_title]=="" ? "untitled project" : params[:project_title]
            response.merge!({status: 'grabVideosStarted',job_id: job_id})
            RenderQueue.create(user_id: current_user.id, title: project_title, job_id: job_id, stage: 'copying_videos')
            puts "Starting To Collect Videos on job_id: #{job_id}"
          end
          #response.merge!({status: grabVidURLs(params[:urls]) ? 'videosDownloaded' : 'downloadFailed'})
        when 'grabPhotos'
          if params[:urls].nil? || params[:urls].empty?
            response = {status: 'emptyList'}
          else
            job_id = RenderWorker.perform_async(current_user.id,params[:urls],'slideshow')
            project_title = params[:project_title]=="" ? "untitled project" : params[:project_title]
            response.merge!({status: 'grabPhotosStarted',job_id: job_id})
            RenderQueue.create(user_id: current_user.id, title: project_title, job_id: job_id, stage: 'copying_photos')
            puts "Starting To Collect Photos on job_id: #{job_id}"
          end
        when 'stopRender'
          puts "Stopping Render on job_id: #{params[:slot]}"
          response.merge!({status: 'renderStop',job_id: rand(200)})
        else
          response = {status: 'Command Not Recognized'}
        end
    else
      response = {status: 'Query is empty'}
    end
    render json: response
  end

private

  def returnUserJobs(user)
    user_found = RenderQueue.where(user_id: user).all
    #unless user_found.nil? return user_found.map{|index| index.job_id}
  end

end
