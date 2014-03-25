class MediaController < ApplicationController
include SearchHelper
respond_to :json

  def popular
    @media = grab_popular_media
    @message = "Popular Media"
  end

  def update_popular
    @media = grab_popular_media
    render partial: "display_results"
  end

  def search
    if params[:search_data] == ""
      flash[:alert] = "Enter something to search"
      redirect_to :root and return
    end

    @search_content = seperate_values(params[:search_data], ' ')
    similar_tags = find_similar_tags(@search_content)
    @message = "Search Results for #{@search_content}"

    if params[:search] == nil
      @similar_media = grab_all_media(similar_tags).sample(4)
      @media = grab_all_media(@search_content)
    elsif params[:search][:images] == "1" && params[:search][:videos] == "1"
      @similar_media = grab_all_media(similar_tags).sample(4)
      @media = grab_all_media(@search_content)
    elsif params[:search][:images] == "1"
      @similar_media = grab_select_media(similar_tags, "image").sample(4)
      @media = grab_select_media(@search_content, "image")
    elsif params[:search][:videos] == "1"
      @similar_media = grab_select_media(similar_tags, "video").sample(4)
      @media = grab_select_media(@search_content, "video")
    end

    if current_user
      @flagged_media = FlaggedContent.where(user_id: current_user.id).pluck(:url)
    end
  end

  def more_results
    @media = []
    current_max_ids = session[:next_max_id]
    session[:next_max_id] = []

    session[:search_terms].each_with_index do |value, index|
      session[:next_max_id] << Instagram.tag_recent_media(value, :max_id => current_max_ids[index]).pagination.next_max_id
      for item in Instagram.tag_recent_media(value)
        @media << item
      end
    end

    render partial: "display_results"
  end

  def save_media
    thumbnail_url = params[:media_thumbnail]
    media = params[:media]
    current_user.flagged_contents << FlaggedContent.create(url: media, thumbnail: thumbnail_url)
    render :json => { count: current_user.flagged_contents.length}
  end

  def remove_media
    remove_media = FlaggedContent.where(user_id: current_user.id, url: params[:media])
    remove_media.destroy_all
    render :json => { count: current_user.flagged_contents.length }
  end

  def recent_media
    @media = Video.all.limit(20)
    #@slideshows = SlideShow.all
  end

  def selected_media
    @media = FlaggedContent.where(user_id: current_user.id)
  end

  def event_media
    session[:next_user_max_id] = nil
    @username =  Instagram.user(params[:user_id]).username
    @id = params[:user_id]
    @media = find_user_media(params[:user_id])
  end

  def event_media_pagination
    if !session[:next_user_max_id]
      session[:next_user_max_id] = Instagram.user_recent_media(params[:user_id]).pagination.next_max_id
    else
      session[:next_user_max_id] = Instagram.user_recent_media(params[:user_id], :max_id => session[:next_user_max_id]).pagination.next_max_id
    end

    @media = []
    for item in Instagram.user_recent_media(params[:user_id], :max_id => session[:next_user_max_id])
      @media << item
    end

    render partial: "display_results"
  end
end
