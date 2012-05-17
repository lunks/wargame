class FacilityFleetsController < ApplicationController
  before_filter :find_resources, :only => [:new, :create]

  def index
  end

  def new
    @facility_fleet = FacilityFleet.new
  end

  def create
    #@facility_fleet = FacilityFleet.new params[:facility_fleet]
    current_squad.buy params[:facility_fleet], 1, @planet
    #@facility_fleet.planet = @planet
    #@facility_fleet.squad = current_squad
    #if @facility_fleet.save
    #  redirect_to fleets_path
    #else
    #  render 'new'
    #end
    redirect_to :fleets
  end


  def edit
    @facility = FacilityFleet.find(params[:id])
    @units = Unit.allowed_for(current_squad.faction)
    @planet = @facility.planet
    unless @facility.producing_unit.present?
      @producing_capacity = 0
      @current_producing_unit_status = 0
    end
  end

  def update
    @facility = FacilityFleet.find(params[:id])
    unless params[:facility_fleet][:producing_unit].empty?
      @producing_unit = Unit.find(params[:facility_fleet][:producing_unit])
      current_squad.change_producing_unit @facility, @producing_unit
    end
    redirect_to :fleets
  end

  private
  def find_resources
    @planet = Planet.find params[:planet_id]
    @facilities = Facility.allowed_for(current_squad.faction)
  end

end

