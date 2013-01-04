class GenericFleet < ActiveRecord::Base
  default_scope :order => "moving ASC, updated_at DESC"
  scope :owned_by, lambda {|squad| where(:squad => squad)}
  belongs_to :squad
  belongs_to :planet
  belongs_to :generic_unit

  after_save :destroy_if_empty

  delegate :name, :to => :generic_unit

  def blast! quantity
    self.quantity -= quantity
    save
  end

  def capture! quantity, squad
    FacilityFleet.is_free
    captured_fleet = self.clone
    captured_fleet.update_attributes(:squad => squad, :quantity => quantity, :type => self.type, :balance => self.balance, :level => self.level, :fleet_name => self.fleet_name)
    captured_fleet.balance = 0 - self.capacity if captured_fleet.is_a? FacilityFleet
    captured_fleet.save
    self.quantity = self.quantity - quantity
    save
  end

  def sabotage! quantity
    sabotaged_fleet = self.clone
    sabotaged_fleet.quantity = quantity
    sabotaged_fleet.sabotaged = true
    sabotaged_fleet.save
    self.quantity = self.quantity - quantity
    save
  end

  def type?(type)
    generic_unit.is_a? type
  end

  def destroy_if_empty
    destroy if self.quantity == 0
  end

  def to_s
    name
  end

  def change_fleet_name name
    self.fleet_name = name
    save
  end

end
