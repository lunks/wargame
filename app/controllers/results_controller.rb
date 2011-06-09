class ResultsController < ApplicationController
  def index
    @planet = Planet.find(params[:planet_id])
    @squads = @planet.squads
    @fleets = GenericFleet.where(:planet => @planet)
    @results = Result.where(:round => Round.getInstance, :planet => @planet)
  end

  def create
    results = params[:results]
    saved_results = results.all? do |result_attributes|
      result = Result.find(result_attributes[0])
      result.attributes = result_attributes[1]
      result.save
    end
    @results = results
    if saved_results
      redirect_to fleets_path
    else
      redirect_to planet_results_path(params[:planet_id])
    end
  end
end

