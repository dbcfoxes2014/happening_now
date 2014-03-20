class HomeController < ApplicationController
  def index
  	@user = current_user
  end

  def search
    @media = Instagram.media_popular
    puts @media
    # redirect_to :home
  end

  def show

  end
end
