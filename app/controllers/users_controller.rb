include SearchHelper
class UsersController < ApplicationController
  respond_to :json

  def show
    @user = User.where(id: params[:id]).first
  end






end