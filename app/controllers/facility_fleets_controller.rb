class FacilityFleetsController < ApplicationController

  def index
  end

  def edit
    @facility = FacilityFleet.find(params[:id])
    @units = Unit.allowed_for(current_squad.faction)
    @planet = @facility.planet
    if @facility.producing_unit.present?
      @producing_capacity = @facility.generic_unit.price / 4
      @current_producing_unit_status = @facility.balance / @facility.producing_unit.price.to_f * 100
    else
      @producing_capacity = 0
      @current_producing_unit_status = 0
    end
  end

  def update
    @facility = FacilityFleet.find(params[:id])
    unless params[:facility_fleet][:producing_unit].empty?
      @producing_unit = Unit.find(params[:facility_fleet][:producing_unit])
      current_squad.change_producing_unit @facility, @producing_unit
    end
    redirect_to :fleets
  end

end

