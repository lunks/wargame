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
    end
    redirect_to planet_results_path(params[:planet_id])
  end

  def show_results
    @squad = current_squad
    @planets = Planet.fog_of_war_seen_by(current_squad) 
  end
end

