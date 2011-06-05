class ResultsController < ApplicationController
  def index
    @planet = Planet.find(params[:planet_id])
    @squads = @planet.squads
    @fleets = GenericFleet.where(:planet => @planet)
    @results = @fleets.map do |fleet|
      Result.find_or_initialize_by_generic_fleet_id_and_planet_id(:generic_fleet => fleet, :planet => @planet, :squad => fleet.squad, :round => Round.getInstance, :generic_unit_id => fleet.generic_unit.id, :quantity => fleet.quantity)
    end
  end

  def create
    render 'index'

  end
end

