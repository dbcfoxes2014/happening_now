class HomeController < ApplicationController
  respond_to :json

  def index
    @user = current_user
  end

  def popular
    @media = []
    @message = "Popular Media"

    for item in Instagram.media_popular
      @media << item
    end

    render :display
    
  end

  def search
    @media = []
    @search_content = params[:search_data]
    @message = "Search Results for #{@search_content}"

    for item in Instagram.tag_recent_media(@search_content)
      if params[:commit] == "Search Photos"
        if item.type == "image"
          @media << item
        end
      elsif params[:commit] == "Search Videos"
        if item.type == "video"
          @media << item
        end
      else
        @media << item
      end
    end

    render :display
  end
end
