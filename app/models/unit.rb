class Unit < GenericUnit
  scope :fighter, where("price >= ?", 350)
  scope :capital_ship, where(:price => 2500...3500)
end
