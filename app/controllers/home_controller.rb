include SearchHelper
class HomeController < ApplicationController
  respond_to :json

  def index
    @user = current_user
  end

  def popular
    @media = grab_popular_media
    @message = "Popular Media"

    render :display
  end

  def search
    if params[:search_data] == ""
      flash[:alert] = "Enter something to search"
      redirect_to :root and return
    end

    @search_content = seperate_values(params[:search_data], ' ')
    @message = "Search Results for #{@search_content}"

    if params[:commit] == "Search Images"
      @media = grab_select_media(@search_content, "image")
    elsif params[:commit] == "Search Videos"
      @media = grab_select_media(@search_content, "video")
    else
      @media = grab_all_media(@search_content)
    end

    render :display
  end

  def save_media
    session[:media_url] ||= []
    session[:media_url].push(params[:media_url])
  end

  def remove_media
    session[:media_url].delete(params[:media_url])
  end

  def debug_grab_test_urls
    #this method will grab the urls as an array
    search_terms = ["puppies", "dogs", "cats", "airplanes", "skateboarding", "dbc", "water", "fly"]
    @content = grab_select_media(search_terms, "video")

    render partial: "debug_grab_test_urls"
   end
end
