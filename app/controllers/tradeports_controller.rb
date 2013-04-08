class TradeportsController < ApplicationController

  def index
    @planet = Planet.find(params[:id])
  end

  def show
    @planet = Planet.find(params[:id])
    @squad = current_squad
    @fleets = @planet.generic_fleets.where(:type => 'Fleet', :moving => nil).all
    @tradeport_stock = Tradeport.where("squad_id == ?", @squad.id)
    @tradeport_stock << Tradeport.where(:squad_id => nil).last
  end

  def buy
    @unit = Fleet.find(params[:fleet][:id])
    @quantity = params[:fleet][:quantity].to_i
    Tradeport.buy_unit @unit, @quantity if @quantity <= @unit.quantity unless @quantity > @unit.quantity
    redirect_to :back
  end

  def sell
    @planet = Planet.find(params[:fleet][:planet])
    @unit = Tradeport.find(params[:fleet][:id])
    @quantity = params[:fleet][:quantity].to_i
    @unit.sell_unit @planet, current_squad, @quantity unless @quantity > @unit.quantity
    redirect_to :back
  end

end

