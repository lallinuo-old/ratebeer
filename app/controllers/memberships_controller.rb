class MembershipsController < ApplicationController
  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memberships }
    end
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
    @membership = Membership.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/new
  # GET /memberships/new.json
  def new
    @users = User.all
    @beer_clubs = BeerClub.all
    @membership = Membership.new(:confirmed=>false)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/1/edit
  def edit
    @membership = Membership.find(params[:id])
  end

  # POST /memberships
  # POST /memberships.json
  def create

   @membership = Membership.new(params[:membership])

  if current_user.beer_clubs.include? @membership.beer_club
    redirect_to :back , :notice => "Already in club"
  else
    current_user.memberships << @membership
    redirect_to @membership.beer_club
  end
  end

  # PUT /memberships/1
  # PUT /memberships/1.json
  def update
    @membership = Membership.find(params[:id])

    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to memberships_url }
      format.json { head :no_content }
    end
  end

  def toggle_confirmation
    membership = Membership.find(params[:id])
    bc = membership.beer_club
    if current_user_is_bc_member?(bc)
      if(current_user)
      membership.update_attribute :confirmed, (not membership.confirmed)

      new_status = membership.confirmed? ? "confirmed" : "removed"

      redirect_to :back, :notice => "User membership #{new_status}"
        return
      end
    end
    redirect_to :back, :notice => "You are not beerclub member"

  end
end
