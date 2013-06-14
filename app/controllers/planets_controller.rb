class PlanetsController < ApplicationController

  before_filter :authenticate_user!, :except => [:map]
  respond_to :html, :xml

  def index

  end

  def show
    @planet = Planet.find(params[:id])
    @round = Round.getInstance
    @squad = current_squad
  end

  def move
    @planet = Planet.find(params[:id])
    @fleets = @planet.generic_fleets.where(:squad => current_squad, :type => 'Fleet')
    @facilities = @planet.generic_fleets.where(:squad => current_squad, :type => 'FacilityFleet')
    @routes = @planet.routes
    redirect_to :close_popup if @fleets.empty? and @facilities.empty?
    move_planet_path(@planet)
  end
 

  def results
    @planet = Planet.find(params[:id])
    @fleets = @planet.generic_fleets
  end

  def map
    @round = Round.getInstance
    @current_squad = current_squad
    @planets = Planet.includes(:squad).all
    #@planets = Planet.seen_by(current_squad)
    respond_with @planets
  end

end

