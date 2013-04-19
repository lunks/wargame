require 'forgery'
Factory.define :generic_unit do |f|
  f.name { Forgery::Name.full_name }
  f.price { Forgery::Basic.number }
  f.factions 'empire'
  f.description 'comboio'
end

Factory.define :planet do |f|
  f.name Forgery::Name.full_name
  f.credits 1000
end

Factory.define :squad do |f|
  f.name Forgery::Name.full_name
  f.credits { Forgery::Basic.number(:at_least => 5000, :at_most => 10000) }
  f.color '00FF00'
  f.faction 'empire'
  f.home_planet {|a| a.association(:planet)}
end

Factory.define :generic_fleet do |f|
  f.generic_unit {|a| a.association(:generic_unit) }
  f.squad {|a| a.association(:squad) }
  f.quantity Forgery::Basic.number
end

Factory.define :facility, :class => Facility, :parent => :generic_unit do |f|
  f.price 500
end

Factory.define :fleet, :class => Fleet, :parent => :generic_fleet do |f|
end

Factory.define :unit, :class => Unit, :parent => :generic_unit do |f|
end

Factory.define :fighter, :class => Fighter, :parent => :unit do |f|
  f.price 100
end

Factory.define :capital_ship, :class => CapitalShip, :parent => :unit do |f|
  f.price 500
end

Factory.define :trooper, :class => Trooper, :parent => :unit do |f|
  f.price 2
end

Factory.define :light_transport, :class => LightTransport, :parent => :unit do |f|
  f.price 100
end

Factory.define :armament, :class => Armament, :parent => :unit do |f|
end

Factory.define :warrior, :class => Warrior, :parent => :unit do |f|
  f.price 50
end


Factory.define :facility_fleet, :class => FacilityFleet, :parent => :generic_fleet do |f|
  f.facility {|a| a.association(:facility) }
end

Factory.define :rebels, :parent => :squad do |f|
end

Factory.define :user do |f|
  f.email Forgery::Internet.email_address
  f.password Forgery::Basic.password
end

Factory.define :route do |f|
  f.vector_a {|a| a.association(:planet)}
  f.vector_b {|a| a.association(:planet)}
end

Factory.define :round do |f|
  f.number 1
end

Factory.define :result do |f|
  f.association :round
  f.association :planet
  f.association :squad
  f.association :generic_unit
  f.quantity 10
  f.after_build do |f|
    f.generic_fleet = Factory :generic_fleet, :generic_unit => f.generic_unit, :planet => f.planet, :quantity => f.quantity
  end
end

Factory.define :tradeport do |f|
  f.association :generic_unit
  f.quantity 1
  f.negotiation_rate 50
end

Factory.define :goal do |f|
  f.description Forgery::Name.full_name
end
