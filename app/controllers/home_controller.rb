include SearchHelper

class HomeController < ApplicationController
  respond_to :json

  def index
    @user = current_user
  end
  
  def debug_grab_test_urls
    #this method will grab the urls as an array
    search_terms = ["puppies", "dogs", "cats", "airplanes", "skateboarding", "dbc", "water", "fly"]
    @content = grab_select_media(search_terms, "video")
    render partial: "debug_grab_test_urls"
  end

  def events
  end
end
