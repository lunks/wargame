class GenericFleetsController < ApplicationController
  def index
    @planets = Planet.seen_by(current_squad)
    @round = Round.getInstance
    @squad = current_squad
    @all_squads = Squad.all

    @small_fleet = nil
    total = 0 
    @planets.each do |planet|
      @all_squads.each do |squad|
        planet.generic_fleets.where(:squad => squad).each do |qtd|
          total += qtd.quantity * qtd.generic_unit.price
        end
        @small_fleet = true if total < 200 and total != 0
        total = 0
      end
    end
  end

  def move
    @round = Round.getInstance
    @fleet = Fleet.find(params[:fleet][:id])
    unless params[:fleet][:destination].empty?
      @planet = Planet.find(params[:fleet][:destination])
      @fleet.move params[:fleet][:quantity].to_i, @planet unless current_squad.ready? || @round.attack?
    else
      @planet = nil
      @fleet.move params[:fleet][:quantity].to_i, @planet unless current_squad.ready? || @round.attack?
    end
    redirect_to :back
  end

  def move_facility
    @round = Round.getInstance
    @facility = FacilityFleet.find(params[:facility_fleet][:id])
    unless params[:facility_fleet][:destination].empty?
      @planet = Planet.find(params[:facility_fleet][:destination])
      @facility.move @planet unless current_squad.ready? || @round.attack?
    else
      @planet = nil
      @facility.move @planet unless current_squad.ready? || @round.attack?
    end
    redirect_to :back
  end

  def back_to_main
    redirect_to :fleets
  end

  def edit
    @fleet = GenericFleet.find(params[:id])
@@fleet = GenericFleet.find(params[:id])
    @planet = @fleet.planet
    @carriable_fleets = Fleet.where(:planet => @fleet.planet, :squad => @fleet.squad, :carried_by_id => nil, :moving => nil).reject! { |fleet| fleet == @fleet || fleet.type?(LightTransport) || fleet.type?(CapitalShip) || fleet.type?(Sensor) }
    @carried_fleets = Fleet.where(:carried_by => @fleet)
  end

  def carregar
    @carriable_fleets = params[:carriable_fleets]
    carrier = @@fleet
    @carriable_fleets.each do [id]
      carriable_fleet = GenericFleet.find(id)
      carriable_fleet.load_in carrier, quantity
    end
  end

  def update
    @fleet = GenericFleet.find(params[:id])
    @fleet.change_fleet_name(params[:fleet][:fleet_name])
    redirect_to :back
  end

  def sensor
    @fleet = GenericFleet.find(params[:id])
    @planet = @fleet.planet
    @routes = @planet.routes
    @current_squad = current_squad 
  end

end
