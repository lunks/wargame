class FacilitiesController < ApplicationController
  
  def buy
    @planet = Planet.find(params[:id])
    @facilities = Facility.allowed_for(current_squad.faction)
  end

  def buy_facility
    @facility = Facility.find(params[:buy_facility][:id])
    @planet = Planet.find(params[:buy_facility][:planet])
    if current_squad.credits >= @facility.price
      current_squad.buy @facility, 1, @planet
    end
    redirect_to :fleets
  end

end
