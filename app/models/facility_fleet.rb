class FacilityFleet < GenericFleet
  belongs_to :producing_unit, :class_name => "Unit"
  belongs_to :facility, :foreign_key => :generic_unit_id
  def produce!
    self.balance ||= 0
    self.balance += facility.price/5
    return if producing_unit.nil?
    unit_price = producing_unit.price
    units = 0
    while producing_unit.price < self.balance
      units++
      self.balance -= unit_price
    end
    Fleet.create_from_facility producing_unit, units, self.planet
    save
  end
end
