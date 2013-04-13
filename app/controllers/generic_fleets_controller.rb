class GenericFleetsController < ApplicationController
  def index
    @planets = Planet.seen_by(current_squad)
    @round = Round.getInstance
    @squad = current_squad
    @all_squads = Squad.all
    @income = 0
    @flee_tax = (@squad.flee_tax @round).to_i
    Planet.where(:squad => @squad).each do |planet|
      @income += (planet.air_credits if planet.air_credits.present?).to_i
    end
    Planet.where(:ground_squad => @squad).each do |planet|
      @income += (planet.ground_credits if planet.ground_credits.present?).to_i
    end
    @provided = (current_squad.credits + @income - @flee_tax).to_i
    if @round.move?
      @round_phase = 'Estrategia'
    else
      @round_phase = 'Combates'
    end
     
    @capital_ships = 0
    @facilities = 0
    @fighters = 0
    @troopers = 0
    @transports = 0
    GenericFleet.all.each do |fleet|
      @capital_ships += fleet.quantity if fleet.type?(CapitalShip)
      @facilities += fleet.quantity if fleet.type?(Facility)
      @fighters += fleet.quantity if fleet.type?(Fighter)
      @troopers += fleet.quantity if fleet.type?(Trooper)
      @transports += fleet.quantity if fleet.type?(LightTransport)
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
