class Planet < ActiveRecord::Base
  belongs_to :squad
  has_many :generic_fleets

  def credits_per_turn
    if generic_fleets.empty? || total_fleet_value < 1000
      0
    else
      credits
    end
  end

  def set_ownership
    if total_fleet_value > 1000
      self.squad = generic_fleets.first.squad
    else
      self.squad = nil
    end
  end
  def total_fleet_value
    fleets_value = 0
    generic_fleets.each do |fleet|
      fleets_value += fleet.generic_unit.price * fleet.quantity
    end
    fleets_value
  end
end

