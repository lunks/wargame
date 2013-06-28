class GenericFleetsController < ApplicationController
  def index
    @planets = Planet.seen_by(current_squad)
    @round = Round.getInstance
    @squad = current_squad
    @all_squads = Squad.all
    @inactive = FacilityFleet.where(:squad => @squad, :producing_unit_id => nil).count + FacilityFleet.where(:squad => @squad, :producing_unit2_id => nil).count
    if @round.move?
      @round_phase = 'Estrategia'
      @tip = "Realize movimentos, configuracao de fabricas, compra/venda de naves e nomeacao de capital ships."
    else
      @round_phase = 'Combates'
      @tip = "Informe os resultados dos combates."
    end
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
    @fleets = params[:fleets]
    @fleets.each do |id, attributes|
      @fleet = GenericFleet.find(id)
      unless  attributes[:quantity].empty?
        @fleet.move attributes[:quantity].to_i, Planet.find(attributes[:destination_id].to_i) unless current_squad.ready? || @round.attack? || attributes[:destination_id].empty? || @fleet.type?(Facility)
        @fleet.move Planet.find(attributes[:destination_id].to_i) unless current_squad.ready? || @round.attack? || attributes[:destination_id].empty? || !@fleet.type?(Facility)
      else
        @fleet.move 1, nil unless current_squad.ready? || @round.attack? || @fleet.type?(Facility)
        @fleet.move nil unless current_squad.ready? || @round.attack? || !@fleet.type?(Facility)
      end
    end
  #redirect_to :back
  @planet = @fleet.planet
  redirect_to :controller => 'planets', :action => 'show', :id => @planet.id
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
