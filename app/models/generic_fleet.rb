class GenericFleet < ActiveRecord::Base
  default_scope :order => "updated_at DESC"
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
    captured_fleet.squad = squad
    captured_fleet.quantity = quantity
    captured_fleet.type = self.type
    captured_fleet.save
    captured_fleet.balance = self.balance
    captured_fleet.save
    captured_fleet.balance = self.capacity - self.capacity * 2 if captured_fleet.is_a? FacilityFleet
    captured_fleet.save
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
end

