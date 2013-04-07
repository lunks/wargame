class TradeportsController < ApplicationController

  def index
    @planet = Planet.find(params[:id])
  end

  def show
    @planet = Planet.find(params[:id])
    @squad = current_squad
    @fleets = @planet.generic_fleets.where(:type => 'Fleet').all
    @tradeport_stock = Tradeport.where(:planet => @planet).all
  end

  def buy
    @unit = Fleet.find(params[:fleet][:id])
    @quantity = params[:fleet][:quantity].to_i
    Tradeport.buy_unit @unit.planet, @unit, @quantity if @quantity <= @unit.quantity
  end

  def sell
    @unit = Tradeport.find(params[:fleet][:id])
    @quantity = params[:fleet][:quantity].to_i
    @unit.sell_unit current_squad, @quantity
    #Tradeport.buy_unit @planet, @unit, @quantity if @quantity <= @unit.quantity
  end


  def xxxx
    @facility = FacilityFleet.find(params[:id])
    unless params[:facility_fleet][:producing_unit].empty?
      @producing_unit = Unit.find(params[:facility_fleet][:producing_unit])
      current_squad.change_producing_unit @facility, @producing_unit
    end
    unless params[:facility_fleet][:producing_unit2].empty?
      @producing_unit2 = Unit.find(params[:facility_fleet][:producing_unit2])
      current_squad.change_producing_unit2 @facility, @producing_unit2
    end
    redirect_to :back
  end

  def upgrade
    @facility = FacilityFleet.find(params[:facility][:id])
    @facility.upgrade! if current_squad.credits >= @facility.upgrade_cost
    redirect_to :back
  end






end

