class FightersController < ApplicationController

  def edit
    @fighter = GenericFleet.find(params[:id])
    @planet = @fighter.planet
    @armaments = Fleet.select{ |unit| unit.planet == @fighter.planet && unit.squad == @fighter.squad && unit.type?(Armament) && !unit.moving? }
  end

  def arm
    @fighter = GenericFleet.find(params[:fleet][:id])
    @armament = GenericFleet.find(params[:fleet][:weapon1_id])
    @fighter.arm_with @armament unless @fighter.weapon1_id
    redirect_to :back
  end

  def disarm
    @fighter = GenericFleet.find(params[:fleet][:id])
    @fighter.disarm unless @fighter.weapon1_id == nil
    redirect_to :back
  end

end
