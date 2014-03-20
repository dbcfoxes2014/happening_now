class UsersController < ApplicationController
  def show
    @user = User.where(id: params[:id]).first
  end
end