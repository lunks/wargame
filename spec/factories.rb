Factory.define :ship do |f|
  f.name Forgery::Name.full_name
  f.price Forgery::Basic.number
end

Factory.define :squad do |f|
  f.name Forgery::Name.full_name
  f.credits Forgery::Basic.number
  f.ships {|a| [a.association(:ship)] }
end

Factory.define :planet do |f|
  f.name Forgery::Name.full_name
end

Factory.define :owned_ship do |f|
  f.ship {|a| a.association(:ship) }
  f.squad {|a| a.association(:squad) }
  f.quantity Forgery::Basic.number
end

