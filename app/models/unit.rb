class Unit < GenericUnit
  scope :fighter, where(:price => 200...500)
end
