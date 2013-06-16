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
    @all_squads = Squad.all
    @flee_tax = (@current_squad.flee_tax @round).to_i
    @ground_income = 0
    @air_income = 0
    Planet.where(:squad => @current_squad).each do |planet|
      @air_income += (planet.air_credits if planet.air_credits.present?).to_i
    end
    Planet.where(:ground_squad => @current_squad).each do |planet|
      @ground_income += (planet.ground_credits if planet.ground_credits.present?).to_i
    end
    @provided = (current_squad.credits + @air_income + @ground_income - @flee_tax).to_i
    if @round.move?
      @round_phase = 'Estrategia'
      @tip = "Realize movimentos, configuracao de fabricas, compra/venda de naves e nomeacao de capital ships."
    else
      @round_phase = 'Combates'
      @tip = "Informe os resultados dos combates."
    end
    @capital_ships = 0
    @facilities = 0
    @fighters = 0
    @troopers = 0
    @transports = 0
    @warriors = 0
    @commanders = 0
    @sensors = 0
    GenericFleet.where(:squad => @current_squad).each do |fleet|
      @capital_ships += fleet.quantity if fleet.type?(CapitalShip)
      @facilities += fleet.quantity if fleet.type?(Facility)
      @fighters += fleet.quantity if fleet.type?(Fighter)
      @troopers += fleet.quantity if fleet.type?(Trooper)
      @transports += fleet.quantity if fleet.type?(LightTransport)
      @warriors += 1 if fleet.type?(Warrior)
      @commanders += 1 if fleet.type?(Commander)
      @sensors += 1 if fleet.type?(Sensor)
    end
    @inactive = FacilityFleet.where(:squad => @current_squad, :producing_unit_id => nil).count + FacilityFleet.where(:squad => @current_squad, :producing_unit2_id => nil).count
    @comment1 = "."
    @comment1 = " #{@inactive} slots inativos" unless @inactive == 0    
    @comment2 = "."
    @all_squads.each do |squad|
      @comment2 << squad.name + ":pronto  " if squad.ready?
    end

    respond_with @planets
  end

end

