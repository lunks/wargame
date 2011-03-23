class Unit < GenericUnit
  scope :fighter, where("price >= ?", 350)
end
