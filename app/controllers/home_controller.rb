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
    
    # binding.pry
    render :display
  end

  def next
    @media = Instagram.tag_recent_media(session[:tag], {MIN_ID: params[:min_id], MAX_ID: params[:max_id]})
    render :display
  end


  def back

  end
  
  def save_media
    # binding.pry
    session[:media_url] ||= []
    session[:media_url].push(params[:media_url])
    p session[:media_url].first
    p "--------------------- dan new here -----------"

  end
end
