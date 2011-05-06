class GenericFleetsController < ApplicationController
  def index
    @planets = Planet.seen_by(current_squad)
    @round = Round.getInstance
    @squad = current_squad
  end

  def move
    @fleet = Fleet.find(params[:fleet][:id])
    unless params[:fleet][:destination].empty?
      @planet = Planet.find(params[:fleet][:destination])
      @fleet.move params[:fleet][:quantity].to_i, @planet
    end
    redirect_to :fleets
  end

  def results

  end

end
