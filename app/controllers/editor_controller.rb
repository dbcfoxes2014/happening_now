class EditorController < ApplicationController
  def home

  end

  def renderStatus
    responce = {}
    if(params[:query])
      case params[:query]
        when 'slotAvaliable'
          responce.merge!({status: 'renderReady',slot: rand(200)})
        when 'renderTime'
          responce.merge!({status: 'renderTime',time: 12})
        else

        end
    else
      responce = {status: 'Command Not Recognized'}
    end
    render json: responce
  end
  def renderCommand
    responce = {}
    if(params[:command])
      case params[:command]
        when 'grabVideos'
          puts params[:urls]
          responce.merge!({status: 'videosDownloaded'})
        when 'startRender'
          puts "Starting Render on slot: #{params[:slot]}"
          responce.merge!({status: 'renderStart',slot: rand(200)})
        when 'stopRender'
          puts "Stopping Render on slot: #{params[:slot]}"
          responce.merge!({status: 'renderStop',slot: rand(200)})
        when 'verbocity'
          dir = params[:direction]
          if dir == "+"
            puts "Increasing Verbocity"
            responce.merge!({status: 'verbChange',level: 0})
          elsif dir == "-"
            puts "Decreasing Verbocity"
            responce.merge!({status: 'verbChange',level: 0})
          end
        end
    else
      responce = {status: 'Command Not Recognized'}
    end
    render json: responce
  end
end
