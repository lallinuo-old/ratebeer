class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingAPI.places_in(params[:city])
    session[:jou] = params[:city]
    if @places.empty?
      redirect_to places_path, :notice => "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    places = BeermappingAPI.places_in(session[:jou])
    array =  places.select {|place| place.id == params[:id]}
    @place = array[0]
    array2 = BeermappingAPI.getscores(array[0].id)
    @score = array2[0]
  end
end