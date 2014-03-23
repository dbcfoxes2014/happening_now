include SearchHelper
class HomeController < ApplicationController
  respond_to :json

  def index
    @user = current_user
  end

  def popular
    @media = grab_popular_media
    @message = "Popular Media"

    render partial: 'home/display', layout: false
  end

  def search
    if params[:search_data] == ""
      flash[:alert] = "Enter something to search"
      redirect_to :root and return
    end

    @search_content = seperate_values(params[:search_data], ' ')
    similar_tags = find_similar_tags(@search_content)
    @message = "Search Results for #{@search_content}"

    # if params[:commit] == "Search Images"
    #   @media = grab_select_media(@search_content, "image")
    # elsif params[:commit] == "Search Videos"
    #   @similar_media = grab_select_media(similar_tags, "video").sample(4)
    #   @media = grab_select_media(@search_content, "video")
    # else
      @similar_media = grab_all_media(similar_tags).sample(4)
      @media = grab_all_media(@search_content)  
    # end
    render partial: 'home/display', layout: false
  end

  def save_media
      session[:media_url].push(params[:media_url])
  end

  def remove_media
    session[:media_url].delete(params[:media_url])
  end

  def recent_media
    @media = Video.all.limit(20)
    #@slideshows = SlideShow.all

    render partial: 'home/recent_media', layout: false
  end

  def view_selected_media
    @media = []
    session[:media_url].each do |url|
      @media.push(url)
    end

    render partial: 'home/selected_media', layout: false
  end

  def debug_grab_test_urls
    #this method will grab the urls as an array
    search_terms = ["puppies", "dogs", "cats", "airplanes", "skateboarding", "dbc", "water", "fly"]
    @content = grab_select_media(search_terms, "video")
    render partial: "debug_grab_test_urls"
  end
end
