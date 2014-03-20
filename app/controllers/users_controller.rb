class UsersController < ApplicationController
  def show
    @user = User.where(id: params[:id]).first
    if @user
      @posts = @user.posts
    else
      redirect_to root_path
    end
  end
end