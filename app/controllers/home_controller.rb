class HomeController < ApplicationController
  def index
  	@user = current_user
  end

  def video 

  end

  def popular
    @media = []
    Instagram.configure do |config|
      config.client_id = "cf46fbec21fe4f848d9ddb0ace6d0978"
      config.client_secret = "5ab67228feb3463fa6df817770260245"
    end

    for item in Instagram.media_popular
      @media << item
    end
  end

  def search
    @media = []
    @search_content = params[:search_data]
    Instagram.configure do |config|
      config.client_id = "cf46fbec21fe4f848d9ddb0ace6d0978"
      config.client_secret = "5ab67228feb3463fa6df817770260245"
    end

    for item in Instagram.tag_recent_media(@search_content)
      @media << item
    end
  end

  def show

  end
end
