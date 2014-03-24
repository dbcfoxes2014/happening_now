# CODE REVIEW: SearchHelper should be included in to HomeController. Doing it
# this way makes them global methods
include SearchHelper
class HomeController < ApplicationController
  respond_to :json

  def index
    # CODE REVIEW: why not just refer to current_user in the code?
    @user = current_user
  end

  def popular
    @media = grab_popular_media
    @message = "Popular Media"
  end

  def search
    if params[:search_data] == ""
      flash[:alert] = "Enter something to search"
      redirect_to :root and return
    end

    @search_content = seperate_values(params[:search_data], ' ')
    similar_tags = find_similar_tags(@search_content)
    @message = "Search Results for #{@search_content}"

    # CODE REVIEW: This isn't conveying a lot of meaning to me. I'd refactor
    # this out to some methods that describe what's happening better
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

  def paginate
    if !(session[:max_ids])
      media = []
      session[:search_terms].each do |value|
        # CODE REVIEW: why is there not a helper method for this?
        pagination_info = Instagram.tag_recent_media(value).pagination
        for item in Instagram.tag_recent_media(value, {:MAX_ID => pagination_info.next_max_id})
          media << item
        end
      end
    end

    render partial: "display"
  end

  # CODE REVIEW: Why are these "media" actions in the home controller? Doesn't
  # seem like a concern of the home controller to me.
  def save_media
    thumbnail_url = params[:media_thumbnail]
    media = params[:media]
    current_user.flagged_contents << FlaggedContent.create(url: media, thumbnail: thumbnail_url)
 end

  def remove_media
    remove_media = FlaggedContent.where(user_id: current_user.id, url: params[:media])
    remove_media.destroy_all
  end

  def recent_media
    @media = Video.all.limit(20)
    #@slideshows = SlideShow.all
  end

  def selected_media
    @media = FlaggedContent.where(user_id: current_user.id)
  end

  def debug_grab_test_urls
    #this method will grab the urls as an array
    search_terms = ["puppies", "dogs", "cats", "airplanes", "skateboarding", "dbc", "water", "fly"]
    @content = grab_select_media(search_terms, "video")
    render partial: "debug_grab_test_urls"
  end
end
