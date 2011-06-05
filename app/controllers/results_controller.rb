class ResultsController < ApplicationController
  def index
    @planet = Planet.find(params[:planet_id])
    @squads = @planet.squads
    @fleets = GenericFleet.where(:planet => @planet)
    @results = Result.where(:round => Round.getInstance, :planet => @planet)
  end

  def create
    results = params[:results]
    results.each do |result_attributes|
      result = Result.find(result_attributes[0])
      result.update_attributes(result_attributes[1])
    end
    @results = results
    redirect_to fleets_path
  end
end

