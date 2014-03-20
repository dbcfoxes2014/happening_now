class HomeController < ApplicationController

  def index
  	@user = current_user
  end

  puts $IG_CLIENT

  def popular
    @media = []
    Instagram.configure do |config|
      config.client_id = ENV['CLIENT_ID']
      config.client_secret = ENV['CLIENT_SECRET']
    end

    for item in Instagram.media_popular
      @media << item
    end
  end

  def search
    @media = []
    @search_content = params[:search_data]
    Instagram.configure do |config|
      config.client_id = ENV[CLIENT_ID]
      config.client_secret = ENV[CLIENT_SECRET]
    end

    for item in Instagram.tag_recent_media(@search_content)
      @media << item
    end


  end

  def show

  end
end
