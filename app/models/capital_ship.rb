class CapitalShip < Unit
  scope :capital_ship, where(:price => 2500...3500)
end

