class PlanetsController < ApplicationController

  def index
    @fleets = current_squad.generic_fleets.all
  end


end

