class CapitalShipsController < ApplicationController

  def edit
    @capital_ship = GenericFleet.find(params[:id])
    @planet = @capital_ship.planet
    @carriable_fleets = Fleet.where(:planet => @capital_ship.planet, :squad => @capital_ship.squad, :carried_by_id => nil, :moving => nil).reject! { |fleet| fleet == @capital_ship || fleet.type?(LightTransport) || fleet.type?(CapitalShip) || fleet.type?(Sensor) }
    @carried_fleets = GenericFleet.where(:carried_by => @capital_ship)
  end

  def update
    @capital_ship = GenericFleet.find(params[:id])
    @capital_ship.change_fleet_name(params[:fleet][:fleet_name])
    redirect_to :back
  end

  def load_in
    @fleet = GenericFleet.find(params[:fleet][:id])
    @capital_ship = GenericFleet.find(params[:id])
    @fleet.load_in @capital_ship, params[:fleet][:quantity].to_i
    redirect_to :back
  end

  def unload_from
    @fleet = GenericFleet.find(params[:fleet][:id])
    @capital_ship = GenericFleet.find(params[:id])
    @fleet.unload_from @capital_ship, params[:fleet][:quantity].to_i
    redirect_to :back
  end

end

