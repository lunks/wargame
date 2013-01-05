class FacilityFleet < GenericFleet
  before_create :default_values
  validates_presence_of :facility, :squad
  belongs_to :facility, :foreign_key => :generic_unit_id
  belongs_to :producing_unit, :class_name => "Unit"

  delegate :capacity, :to => :facility
  delegate :capacity_upgraded, :to => :facility
  delegate :price, :to => :facility
  class << self
    def is_free
      FacilityFleet.skip_callback(:create, :before, :subtract_credits_from_squad)
    end
  end
  def produce!
    self.balance += default_capacity
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

  def upgrade!
    if self.squad.credits >= upgrade_cost
      self.squad.credits -= upgrade_cost
      self.squad.save
      self.level += 1
      self.save
    end
  end

  def units_per_turn
    (total_capacity / producing_unit.price.to_f).round(2)
  end

  def default_capacity
    capacity + current_upgrade_ratio
  end

  def upgrade_cost
    upgrade_ratio * 3
  end

  def upgrade_ratio
    500
  end

  def current_upgrade_ratio
    500 * level
  end
 
  def total_capacity
    default_capacity + balance
  end


  def building_done
    (balance / producing_unit.price.to_f).round(2)
  end

  def producing_unit_display
    if units_per_turn < 1
      producing_unit_display = producing_unit.name + " #{building_done}%"
    else
      producing_unit_display = producing_unit.name
    end
    producing_unit_display
  end
  
private

  def default_values
    self.quantity = 1
    self.balance = 0
    self.level = 0
  end

end
