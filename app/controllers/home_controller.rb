class HomeController < ApplicationController
  def index
  	@user = current_user
  end

  def video

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
        @media << item.images.standard_resolution.url
      elsif params[:commit] == "Search Videos"
        if item.videos
          @media << item.videos.standard_resolution.url
        end
      else
        @media << item
      end
    end
  end

  def show

  end
end
