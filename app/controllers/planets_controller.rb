class PlanetsController < ApplicationController

  before_filter :authenticate_user!, :except => [:map]
  respond_to :html, :xml

  def index
    @fleets = current_squad.generic_fleets.all
  end

  def move
    @planet = Planet.find(params[:id])
    @fleets = @planet.generic_fleets.where(:squad => current_squad, :type => 'Fleet', :moving => nil)
    @facilities = @planet.generic_fleets.where(:squad => current_squad, :type => 'FacilityFleet', :moving => nil)
    @routes = @planet.routes
    redirect_to :close_popup if @fleets.empty? and @facilities.empty?
    move_planet_path(@planet)
  end
 

  def results
    @planet = Planet.find(params[:id])
    @fleets = @planet.generic_fleets
  end

  def map
    @current_squad = current_squad
    @planets = Planet.includes(:squad).all
    respond_with @planets
  end

end

