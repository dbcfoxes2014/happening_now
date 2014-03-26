require 'open-uri'
require 'uri'
require 'net/http'
require 'net/https'
require 'json'

class MediaController < ApplicationController
include SearchHelper
include BannedWordsHelper
respond_to :json
before_filter :authenticate_user!, only: [:new]

  def popular
    @media = grab_popular_media
    @message = "Popular Media"
  end

  def update_popular
    @media = grab_popular_media
    render partial: "display_results"
  end

  def search
    @media = []
    if params[:search_data] == ""
      flash[:alert] = "Enter something to search"
      redirect_to :root and return
    elsif params[:search_data].first[0] == "@" #an @ at the beginning designates a search for an instagram user
      session[:next_user_max_id] = nil
      params[:search_data] = params[:search_data][1..-1]
      user_id = Instagram.user_search(params[:search_data])
      if user_id.first
        redirect_to :controller => 'media', :action => 'event_media', :user_id => user_id[0].id
      end
    else
      @search_content = join_values(params[:search_data])
      check_search_content_keywords(@search_content)
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
  end

  def paginate_results
    #save current next_urls and then reset them
    current_urls = session[:next_urls]
    session[:next_urls] = []

    #fetch the next set of data from instagram.
    temp_media = []
    current_urls.each_with_index do |url, index|
        temp_media << (fetch(url))
        session[:next_urls].push(temp_media[index]["pagination"]["next_url"])
    end

    @media = temp_media[0]["data"]

    if current_user
      @flagged_media = FlaggedContent.where(user_id: current_user.id).pluck(:url)
    end

    render partial: "display_results"
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


  def save_media
    thumbnail_url = params[:media_thumbnail]
    media = params[:media]
    extension = media.match(/\.([0-9a-z]+)(?:[\?#]|$)/i).captures[0]
    current_user.flagged_contents << FlaggedContent.create(url: media, thumbnail: thumbnail_url, extension: extension)
    render :json => { count: current_user.flagged_contents.length}
  end

  def remove_media
    remove_media = FlaggedContent.where(user_id: current_user.id, url: params[:media])
    remove_media.destroy_all
    render :json => { count: current_user.flagged_contents.length }
  end

  def recent_media
    @media = Video.all.limit(20)
    @media.reverse
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
end
