class GenericUnitsController < ApplicationController
  def index
    @generic_units = GenericUnit.all
  end

  def update
    @generic_unit = GenericUnit.find(params[:id])
    @generic_unit.update_attributes(params[:generic_unit])
    @generic_unit.save
    redirect_to :generic_units
  end
end
