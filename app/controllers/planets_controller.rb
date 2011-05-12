class PlanetsController < ApplicationController
  respond_to :html, :xml
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

  def map
    @planets = Planet.includes(:squad).all
    respond_with @planets
  end



end

