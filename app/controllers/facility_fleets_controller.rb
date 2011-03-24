class FacilityFleetsController < ApplicationController

  def index
    @units = Unit.allowed_for(current_squad)
  end

  def update_production_unit
  end

end

