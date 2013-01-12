class ResultsController < ApplicationController
  def index
    @planet = Planet.find(params[:planet_id])
    @squads = @planet.squads
    @fleets = GenericFleet.where(:planet => @planet)
    @results = Result.where(:round => Round.getInstance, :planet => @planet)
  end

  def create
    @results = params[:results]
    saved_results = @results.all? do |id, attributes|
      result = Result.find(id)
      result.attributes = attributes
      result.save
    end
    if saved_results
      redirect_to :close_popup
    else
      redirect_to planet_results_path(params[:planet_id])
    end
  end
end

