class HomeController < ApplicationController
  respond_to :json

  def index
    @user = current_user
  end


  def video
    # @url = session[:url]
    # binding.pry
    @url = session[:url]
    p @url 
    p "ONE ABOVE-----------------dsfdasfdasfasfa---------"
  end

  def popular
    @media = []

    for item in Instagram.media_popular
      @media << item
    end
  end

  def search
    @media = []
    @search_content = params[:search_data]

    for item in Instagram.tag_recent_media(@search_content)
      if params[:commit] == "Search Photos"
        if item.type == "image"
          @media << item
        end
      elsif params[:commit] == "Search Videos"
        if item.type == "videos"
          @media << item
        end
      elsif params[:commit] == "Search Both"
        @media << item
      end
    end
  end

  def show

  end

  def save_video_url
    puts "heress ----------------------------------------"
    # binding.pry
    session[:url] = params[:url]
    p session[:url]
    p "ABOVE IS SAVE"
    # redirect_to :video
  end
end
