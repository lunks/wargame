class GenericFleetsController < ApplicationController
  def index
    @planets = Planet.seen_by(current_squad)
    @round = Round.getInstance
    @squad = current_squad
    @all_squads = Squad.all
    @flee_tax = (@squad.flee_tax @round).to_i
    @ground_income = 0
    @air_income = 0
    Planet.where(:squad => @squad).each do |planet|
      @air_income += (planet.air_credits if planet.air_credits.present?).to_i
    end
    Planet.where(:ground_squad => @squad).each do |planet|
      @ground_income += (planet.ground_credits if planet.ground_credits.present?).to_i
    end
    @provided = (current_squad.credits + @air_income + @ground_income - @flee_tax).to_i
    if @round.move?
      @round_phase = 'Estratégia'
    else
      @round_phase = 'Combates'
    end
     
    @capital_ships = 0
    @facilities = 0
    @fighters = 0
    @troopers = 0
    @transports = 0
    @warriors = 0
    GenericFleet.where(:squad => @squad).each do |fleet|
      @capital_ships += fleet.quantity if fleet.type?(CapitalShip)
      @facilities += fleet.quantity if fleet.type?(Facility)
      @fighters += fleet.quantity if fleet.type?(Fighter)
      @troopers += fleet.quantity if fleet.type?(Trooper)
      @transports += fleet.quantity if fleet.type?(LightTransport)
      @warriors += 1 if fleet.type?(Warrior)
    end
    @inactive = FacilityFleet.where(:squad => @squad, :producing_unit_id => nil).count
  end

  def move
    @fleet = Fleet.find(params[:fleet][:id])
    unless params[:fleet][:destination].empty?
      @planet = Planet.find(params[:fleet][:destination])
      @fleet.move params[:fleet][:quantity].to_i, @planet
    else
      @planet = nil
      @fleet.move params[:fleet][:quantity].to_i, @planet
    end
    redirect_to :back
  end

  def move_facility
    @facility = FacilityFleet.find(params[:facility_fleet][:id])
    unless params[:facility_fleet][:destination].empty?
      @planet = Planet.find(params[:facility_fleet][:destination])
      @facility.move @planet
    else
      @planet = nil
      @facility.move @planet
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
