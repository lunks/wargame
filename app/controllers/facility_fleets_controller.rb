class FacilityFleetsController < ApplicationController
  before_filter :find_resources, :only => [:new, :create]

  def index
  end

  def new
    @facility_fleet = FacilityFleet.new
  end

  def create
    @facility = GenericUnit.find(params[:facility_fleet][:generic_unit_id])
    current_squad.buy @facility, 1, @planet if current_squad.credits >= @facility.price
    redirect_to fleets_path
  end


  def edit
    @facility = FacilityFleet.find(params[:id])
    @capacity = @facility.capacity + (@facility.capacity * 0.20 * @facility.level).to_i
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

  def upgrade
    @facility = FacilityFleet.find(params[:facility][:id])
    upgrade_cost = @facility.price * 0.20
    @facility.upgrade! if current_squad.credits >= upgrade_cost
    redirect_to :fleets
  end


  private
  def find_resources
    @planet = Planet.find params[:planet_id]
    @facilities = Facility.allowed_for(current_squad.faction)
  end

end

