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

  def toggle_tutorial
    response = {}
    if(params[:toggle])
      case params[:toggle]
        when 'true'
          session[:tutorial_active] = true
          response = {status: 'good'}
        when 'false'
          session.delete(:tutorial_active)
          response = {status: 'good'}
        else
          response = {status: 'Command Not Recognized'}
        end
    else
      response = {status: 'Toggle is empty'}
    end
    render json: response
  end
end
