class FacilityFleetsController < ApplicationController

  def index
  end

  def edit
    #@units = Unit.allowed_for(current_squad) not working....
    @facility = GenericFleet.find(params[:id])
    @units = ['X-Wing', 'Y-Wing', 'Z-95'] #just testing
  end

  def update
    @facility = GenericFleet.find(params[:id])
    redirect_to :fleets
  end

end

