class SensorsController < ApplicationController

  def edit
    @fleet = GenericFleet.find(params[:id])
    @planet = @fleet.planet
    @routes = @planet.routes
    @current_squad = current_squad 
  end

end
