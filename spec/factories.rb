Factory.define :generic_unit do |f|
  f.name Forgery::Name.full_name
  f.price Forgery::Basic.number
end

Factory.define :squad do |f|
  f.name Forgery::Name.full_name
  f.credits Forgery::Basic.number
  f.generic_units {|a| [a.association(:generic_unit)] }
end

Factory.define :planet do |f|
  f.name Forgery::Name.full_name
end

Factory.define :generic_fleet do |f|
  f.generic_unit {|a| a.association(:generic_unit) }
  f.squad {|a| a.association(:squad) }
  f.quantity Forgery::Basic.number
end

Factory.define :facility, :class => Facility, :parent => :generic_unit do |f|
end

Factory.define :fleet, :class => Fleet, :parent => :generic_fleet do |f|
end

Factory.define :unit, :class => Unit, :parent => :generic_unit do |f|
end

Factory.define :facility_fleet, :class => FacilityFleet, :parent => :generic_fleet do |f|
  f.facility {|a| a.association(:facility) }
end
Factory.define :rebels, :parent => :squad do |f|
  f.planets {|a| [a.association(:planet)]}
  f.facilities {|a| [a.association(:facility)]}
  f.units {|a| [a.association(:unit, :price => 350)]}
end

Factory.define :empire, :parent => :squad do |f|
  f.units {|a| [a.association(:unit)]}
end
