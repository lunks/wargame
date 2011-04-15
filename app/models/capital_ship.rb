class CapitalShip < Unit
  default_scope where(:price => 2500...3500)
end

