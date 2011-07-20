class FacilityFleet < GenericFleet
  before_create :default_values, :subtract_credits_from_squad
  validates_presence_of :facility, :squad
  belongs_to :facility, :foreign_key => :generic_unit_id
  belongs_to :producing_unit, :class_name => "Unit"
  class << self
    def is_free
      FacilityFleet.skip_callback(:create, :before, :subtract_credits_from_squad)
    end
  end
  def produce!
    self.balance += capacity
    return if producing_unit.nil?
    unit_price = producing_unit.price
    units = 0
    while unit_price <= self.balance
      units += 1
      self.balance -= unit_price
    end
    Fleet.create_from_facility producing_unit, units, self.planet, self.squad
    save
  end

  def capacity
    facility.price / 4
  end

  def units_per_turn
    (capacity / producing_unit.price.to_f).round(2)
  end

  def building_done
    (balance / producing_unit.price.to_f).round(2)
  end

  def producing_unit_display
    producing_unit_display = producing_unit.name
    producing_unit_display << " (#{building_done}%)" if units_per_turn < 1
    producing_unit_display
  end
  private

  def default_values
    self.quantity = 1
    self.balance = 0
  end

  def subtract_credits_from_squad
    total_price = facility.price * self.quantity
    if squad.credits >= total_price
      squad.credits -= total_price
      squad.save
    else
      false
    end
  end
end
