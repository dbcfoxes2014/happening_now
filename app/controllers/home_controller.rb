include SearchHelper
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
    @search_content = seperate_values(params[:search_data], ' ')
    @message = "Search Results for #{@search_content}"
      
    if params[:commit] == "Search Photos"
      @media = grab_select_media(@search_content, "image")
  
    elsif params[:commit] == "Search Videos"
      @media = grab_select_media(@search_content, "video")
    else
      @media = grab_all_media(@search_content)  
    end    

    render :display
  end
end
