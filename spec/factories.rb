Factory.define :unit do |f|
  f.name Forgery::Name.full_name
  f.price Forgery::Basic.number
end

Factory.define :squad do |f|
  f.name Forgery::Name.full_name
  f.credits Forgery::Basic.number
  f.units {|a| [a.association(:unit)] }
end

Factory.define :planet do |f|
  f.name Forgery::Name.full_name
end

Factory.define :fleet do |f|
  f.unit {|a| a.association(:unit) }
  f.squad {|a| a.association(:squad) }
  f.quantity Forgery::Basic.number
end

