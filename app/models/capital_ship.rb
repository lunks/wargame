class CapitalShip < Unit
  scope :capital_ship, where(:price => 2000...3500)
end

