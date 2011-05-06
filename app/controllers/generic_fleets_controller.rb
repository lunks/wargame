class GenericFleetsController < ApplicationController
  def index
    @planets = Planet.seen_by(current_squad)
    @round = Round.getInstance
  end

  def move
    @fleet = Fleet.find(params[:fleet][:id])
    @planet = Planet.find(params[:fleet][:destination])
    @fleet.move params[:fleet][:quantity].to_i, @planet
    redirect_to :fleets
  end

  def results

  end

end
