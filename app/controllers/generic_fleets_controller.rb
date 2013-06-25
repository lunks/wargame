class GenericFleetsController < ApplicationController
  def index
    @planets = Planet.seen_by(current_squad)
    @round = Round.getInstance
    @squad = current_squad
    @all_squads = Squad.all
    @inactive = FacilityFleet.where(:squad => @squad, :producing_unit_id => nil).count + FacilityFleet.where(:squad => @squad, :producing_unit2_id => nil).count
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
    if params[:fleet]
      @fleet = Fleet.find(params[:fleet][:id])
      unless params[:fleet][:destination].empty?
        @planet = Planet.find(params[:fleet][:destination])
        @fleet.move params[:fleet][:quantity].to_i, @planet unless current_squad.ready? || @round.attack?
      else
        @planet = nil
        @fleet.move params[:fleet][:quantity].to_i, @planet unless current_squad.ready? || @round.attack?
      end
    else
      @facility = FacilityFleet.find(params[:facility_fleet][:id])
      unless params[:facility_fleet][:destination].empty?
        @planet = Planet.find(params[:facility_fleet][:destination])
        @facility.move @planet unless current_squad.ready? || @round.attack?
      else
        @planet = nil
        @facility.move @planet unless current_squad.ready? || @round.attack?
      end
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

end
