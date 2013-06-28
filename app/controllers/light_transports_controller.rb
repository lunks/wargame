class LightTransportsController < ApplicationController

  def edit
    @light_transport = GenericFleet.find(params[:id])
    @planet = @light_transport.planet
    @carriable_fleets = Fleet.where(:planet => @light_transport.planet, :squad => @light_transport.squad, :carried_by_id => nil).reject! { |fleet| fleet == @light_transport || fleet.type?(LightTransport) || fleet.type?(CapitalShip) || fleet.type?(Sensor) || fleet.type?(Fighter) }
    @carried_fleets = GenericFleet.where(:carried_by => @light_transport)
  end

  def load_in
    @fleet = GenericFleet.find(params[:fleet][:id])
    @light_transport = GenericFleet.find(params[:id])
    @fleet.load_in @light_transport, params[:fleet][:quantity].to_i if params[:fleet][:quantity]
    redirect_to :back
  end

  def unload_from
    @fleet = GenericFleet.find(params[:fleet][:id])
    @light_transport = GenericFleet.find(params[:id])
    @fleet.unload_from @light_transport, params[:fleet][:quantity].to_i if params[:fleet][:quantity]
    redirect_to :back
  end

end
