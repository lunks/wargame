class CapitalShip < GenericUnit
  scope :capital_ship, where(:price => 2500...3500)
end

