class FacilitiesController < ApplicationController

  def buy
    @planet = Planet.find(params[:id])
    @facilities = Facility.allowed_for(current_squad.faction)
  end

  def buy_facility
    unless params[:buy_facility][:id].empty? || params[:buy_facility][:planet].empty?
      @facility = Facility.find(params[:buy_facility][:id])
      @planet = Planet.find(params[:buy_facility][:planet])
      current_squad.buy @facility, 1, @planet if current_squad.credits >= @facility.price
      redirect_to new_planet_facility_fleet_path(:planet)
    end
    redirect_to :back
  end

end
