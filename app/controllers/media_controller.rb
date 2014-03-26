require 'open-uri'
require 'uri'
require 'net/http'
require 'net/https'
require 'json'

class MediaController < ApplicationController
include SearchHelper
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

    #marvel at the stream of madness that they've handed over to us.
    #then build an object which will spit it out in a format that our
    #current display method will accept
    @media = []
    temp_media[0]["data"].each_with_index do |content, index|
      @media << {}
      @media[index]["user"] = { "username" => "temp" }
      if content["videos"]
        @media[index]["type"] = "video"
        @media[index]["videos"] = {}
        @media[index]["videos"]["standard_resolution"] = {}
        @media[index]["videos"]["standard_resolution"]["url"] = content["videos"]["standard_resolution"]["url"]
        @media[index]["images"] = { "standard_resolution" => { "url" => "#"} }
        p @media[index]["videos"]["standard_resolution"]["url"]
      else
        @media[index]["type"] = "image"
        @media[index]["images"] = {}
        @media[index]["images"]["standard_resolution"] = {}
        @media[index]["images"]["standard_resolution"]["url"] = content["images"]["standard_resolution"]["url"]
      end
      @media[index]["link"] = "to do -- figure out how to set this"
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
end
