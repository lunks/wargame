class GenericFleetsController < ApplicationController
  def index
    @planets = Planet.seen_by(current_squad)
    @round = Round.getInstance
    @squad = current_squad
    @income = 0
    @flee_tax = @squad.flee_tax @round
    @squad.planets.each do |planet|
      @income += planet.credits_per_turn if planet.credits_per_turn.present?
    end
  end

  def move
    @fleet = Fleet.find(params[:fleet][:id])
    unless params[:fleet][:destination].empty?
      @planet = Planet.find(params[:fleet][:destination])
      @fleet.move params[:fleet][:quantity].to_i, @planet
    end
    redirect_to :fleets
  end

  def back_to_main
    redirect_to :fleets
  end

  def edit
    @fleet = GenericFleet.find(params[:id])
    @planet = @fleet.planet
  end

  def update
    @fleet = GenericFleet.find(params[:id])
    @fleet.change_fleet_name(params[:fleet][:fleet_name])
    redirect_to :fleets
  end
end
