class Unit < GenericUnit
  scope :fighter, where(:price => 60..150)
  scope :capital_ship, where(:price => 500..1000)
end
require 'fighter'
require 'light_transport'
require 'capital_ship'
require 'armament'
require 'trooper'
