include SearchHelper
class UsersController < ApplicationController
  respond_to :json

  def show
    @user = User.where(id: params[:id]).first
  end

  def user_videos
  	@user_videos = Video.all(params[:user_id])
  end

  def user_slide_shows
  	@user_slide_shows = SlideShows.all(params[:user_id]) 	
  end	
end