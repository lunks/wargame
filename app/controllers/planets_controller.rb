class PlanetsController < ApplicationController

  def index
    @fleets = current_squad.generic_fleets.all
  end

  def move
    @planet = Planet.find(params[:id])
    @fleets = @planet.generic_fleets.where(:squad => current_squad, :type => 'Fleet', :moving => nil)
    @routes = @planet.routes
    redirect_to :fleets if @fleets.empty?
  end

  def results
    @planet = Planet.find(params[:id])
    @fleets = @planet.generic_fleets
  end


end

