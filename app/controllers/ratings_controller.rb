class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end
  def new
    @rating = Rating.new
    @beers = Beer.all
  end


  def create
    rating = Rating.create params[:rating]
    current_user.ratings << rating

    redirect_to user_path current_user
  end
  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end

