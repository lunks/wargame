class GenericFleetsController < ApplicationController
  def index
    @planets = Planet.seen_by(current_squad)
    @round = Round.getInstance
    @squad = current_squad
    @all_squads = Squad.all
    @income = 0
    @flee_tax = @squad.flee_tax @round
    Planet.where(:squad => @squad).each do |planet|
      @income += planet.air_credits if planet.air_credits.present?
    end
    Planet.where(:ground_squad => @squad).each do |planet|
      @income += planet.ground_credits if planet.ground_credits.present?
    end
    if @round.move?
      @round_phase = 'Estrategia'
    else
      @round_phase = 'Combates'
    end
  end

  def move
    @fleet = Fleet.find(params[:fleet][:id])
    unless params[:fleet][:destination].empty?
      @planet = Planet.find(params[:fleet][:destination])
      @fleet.move params[:fleet][:quantity].to_i, @planet
    end
    redirect_to :back
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
    redirect_to :back
  end
end
