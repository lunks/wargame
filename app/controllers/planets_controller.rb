class PlanetsController < ApplicationController

  def index
    @fleets = current_squad.generic_fleets.all
  end

  def move
    @planet = Planet.find(params[:id])
    @fleets = @planet.generic_fleets.where(:squad => current_squad, :type => 'Fleet')
    @routes = @planet.routes
  end


end

