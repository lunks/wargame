class CapitalShip < GenericUnit
  default_scope where(:price => 2500...3500)
end

