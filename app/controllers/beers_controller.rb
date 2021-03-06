class BeersController < ApplicationController
  before_filter :ensure_that_signed_in, :except => [:index, :show]


  # GET /beers
  # GET /beers.json
  def index
    @beers = Beer.all
    @order = params[:order] || 'name'

    @beers = Beer.all(:include => [:brewery, :style]).sort_by{ |b| b.send(@order) }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @beers, :methods => [ :brewery, :style ] }
    end
  end

  # GET /beers/1
  # GET /beers/1.json
  def show

    @beer = Beer.find(params[:id])
    @rating = Rating.new
    @rating.beer = @beer

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beer }
    end
  end

  # GET /beers/new
  # GET /beers/new.json
  def new
    @beer = Beer.new
    @breweries = Brewery.all
    @styles = Style.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beer }
    end
  end

  # GET /beers/1/edit
  def edit
    @beer = Beer.find(params[:id])
  end

  # POST /beers
  # POST /beers.json
  def create
    expire_fragment :action => :index
    @beer = Beer.new(params[:beer])

    respond_to do |format|
      if @beer.save
        format.html { redirect_to @beer, notice: 'Beer was successfully created.' }
        format.json { render json: @beer, status: :created, location: @beer }
      else
        @styles = Style.all
        @breweries = Brewery.all
        format.html { render action: "new" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /beers/1
  # PUT /beers/1.json
  def update
    expire_fragment :action => :index
    @beer = Beer.find(params[:id])

    respond_to do |format|
      if @beer.update_attributes(params[:beer])
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    expire_fragment :action => :index
    @beer = Beer.find(params[:id])
    @beer.destroy

    respond_to do |format|
      format.html { redirect_to beers_url }
      format.json { head :no_content }
    end
  end
end
