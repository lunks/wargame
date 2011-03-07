class FacilityFleet < GenericFleet
  belongs_to :producing_unit, :class_name => "Unit"
  belongs_to :facility, :foreign_key => :generic_unit_id
  def produce!
    self.balance = 0 if balance.nil?
    self.balance = self.balance + facility.price/5
    
    return if producing_unit.nil?
    
    #TODO PELO AMOR DE DEUS ACERTA OS RELACIONAMENTOS
    while producing_unit.price < self.balance
      fleet = Fleet.find_or_create_by_generic_unit_id_and_planet_id(:generic_unit_id => producing_unit.id, :planet_id => self.planet_id)
      fleet.quantity = 0 if fleet.quantity.nil?
      fleet.quantity += 1
      fleet.save!
      self.balance -= producing_unit.price
    end
    save
  end
end
