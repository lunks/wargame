class Unit < GenericUnit
  require 'fighter'
  require 'light_transport'
  require 'capital_ship'
  require 'armament'
  require 'trooper'
  scope :fighter, where(:price => 200...500)
end
