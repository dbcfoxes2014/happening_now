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
      @media << item
    end


  end

  def show

  end
end
