class FacilityFleet < GenericFleet
  before_create :default_values
  validates_presence_of :facility, :squad

  belongs_to :facility, :foreign_key => :generic_unit_id
  belongs_to :producing_unit, :class_name => "Unit"
  belongs_to :producing_unit2, :class_name => "Unit"
  belongs_to :destination, :class_name => "Planet"

  delegate :capacity, :to => :facility
  delegate :capacity_upgraded, :to => :facility
  delegate :price, :to => :facility

  class << self
    def is_free
      FacilityFleet.skip_callback(:create, :before, :subtract_credits_from_squad)
    end
  end

  def move planet
      moving_facility = FacilityFleet.new self.attributes
      moving_facility.destination = planet
      if planet == nil
        moving_facility.moving = nil
      else
        moving_facility.moving = true
      end
      moving_facility.save!
      self.quantity = 0
      save
      moving_facility
  end

  def flee! quantity
    fleeing_facility = FacilityFleet.new self.attributes
    fleeing_facility.destination = planet.best_route_for(squad)
    fleeing_facility.moving = true
    fleeing_facility.save!
    self.quantity = 0
    save
    fleeing_facility.move!
    fleeing_facility
  end

  def move!
    update_attributes(:planet => destination)
  end

  def reassembly
    update_attributes(:balance => 0, :level => 0, :moving => nil, :destination_id => nil )
  end

  def produce!
    return if self.moving? || self.planet.tradeport
    self.balance += default_capacity
    secondary_balance = secondary_capacity.to_i
    if producing_unit2.present?
      unit_price = producing_unit2.price
      units = 0
      while unit_price <= secondary_balance
        units += 1
        secondary_balance -= unit_price
      end
      Fleet.create_from_facility producing_unit2, units, self.planet, self.squad
      save
    end
    if producing_unit.present?
      unit_price = producing_unit.price
      units = 0
      while unit_price <= self.balance
        units += 1
        self.balance -= unit_price
      end
      Fleet.create_from_facility producing_unit, units, self.planet, self.squad
      save
    end
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
    (total_capacity / producing_unit.price).to_i
  end

  def units_per_turn2
    (secondary_capacity / producing_unit2.price).to_i
  end

  def default_capacity
    if sabotaged?
      ((capacity + current_upgrade_ratio) * 0.50).to_i
    else
      (capacity + current_upgrade_ratio).to_i
    end
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
    (default_capacity + balance).to_i
  end

  def secondary_capacity
    (default_capacity * 0.30).to_i
  end


  def building_done
    (balance / producing_unit.price * 100).to_i
  end

  def producing_unit_display
    if units_per_turn < 1
      producing_unit_display = producing_unit.name + " #{building_done}%"
    else
      producing_unit_display = producing_unit.name
    end
    producing_unit_display
  end

  def producing_unit2_display
    if units_per_turn2 < 1
      producing_unit2_display = producing_unit2.name + " #{building_done}%"
    else
      producing_unit2_display = producing_unit2.name
    end
    producing_unit2_display
  end

  def name
    if moving?
      facility.description
    else
      facility.name
    end
  end
  
private

  def default_values
    self.quantity = 1
  end

end
