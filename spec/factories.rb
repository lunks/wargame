Factory.define :ship do |f|
  f.name Forgery::Name.full_name
  f.price Forgery::Basic.number
end
Factory.define :squad do |f|
  f.name Forgery::Name.full_name
  f.credits Forgery::Basic.number
  f.ships {|a| [a.association(:ship)] }
end

