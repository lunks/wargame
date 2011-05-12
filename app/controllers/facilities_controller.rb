class FacilitiesController < ApplicationController
  
  def buy
    @planet = Planet.find(params[:id])
    @facilities = Facility.allowed_for(current_squad.faction)
  end

end
