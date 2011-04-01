alderaan = Planet.create(:name => 'Alderaan' , :credits =>  900 )
bespin = Planet.create(:name => 'Bespin' , :credits =>  900 )
bothauwi = Planet.create(:name => 'Bothauwi' , :credits =>  800 )
byss = Planet.create(:name => 'Byss' , :credits =>  600 )
corellia = Planet.create(:name => 'Corellia' , :credits =>  1200 )
coruscant = Planet.create(:name => 'Coruscant' , :credits =>  1000 )
dagobah = Planet.create(:name => 'Dagobah' , :credits =>  800 )
dantooine = Planet.create(:name => 'Dantooine' , :credits =>  700 )
endor = Planet.create(:name => 'Endor' , :credits =>  700 )
eriadu = Planet.create(:name => 'Eriadu' , :credits =>  1000 )
felucia = Planet.create(:name => 'Felucia' , :credits =>  800 )
geonosis = Planet.create(:name => 'Geonosis' , :credits =>  900 )
hoth = Planet.create(:name => 'Hoth' , :credits =>  900 )
ilum = Planet.create(:name => 'Ilum' , :credits =>  600 )
kamino = Planet.create(:name => 'Kamino' , :credits =>  600 )
kashyyyk = Planet.create(:name => 'Kashyyyk' , :credits =>  800 )
kuat = Planet.create(:name => 'Kuat' , :credits =>  800 )
mandalore = Planet.create(:name => 'Mandalore' , :credits =>  800 )
moncalamari = Planet.create(:name => 'Mon Calamari' , :credits =>  600 )
mustafar = Planet.create(:name => 'Mustafar' , :credits =>  800 )
mygeeto = Planet.create(:name => 'Mygeeto' , :credits =>  900 )
naboo = Planet.create(:name => 'Naboo' , :credits =>  900 )
nalhutta = Planet.create(:name => 'Nal Hutta' , :credits =>  800 )
polismassa = Planet.create(:name => 'Polis Massa' , :credits =>  700 )
ryloth = Planet.create(:name => 'Ryloth' , :credits =>  600 )
tatooine = Planet.create(:name => 'Tatooine' , :credits =>  900 )
utapau = Planet.create(:name => 'Utapau' , :credits =>  600 )
yavin = Planet.create(:name => 'Yavin' , :credits =>  800 )

Route.create(:vector_a => mustafar, :vector_b => polismassa, :distance => 1)
Route.create(:vector_a => hoth, :vector_b => polismassa, :distance => 1)
Route.create(:vector_a => eriadu, :vector_b => mustafar, :distance => 1)
Route.create(:vector_a => dagobah, :vector_b => mustafar, :distance => 1)
Route.create(:vector_a => dagobah, :vector_b => utapau, :distance => 1)
Route.create(:vector_a => dagobah, :vector_b => eriadu, :distance => 1)
Route.create(:vector_a => eriadu, :vector_b => hoth, :distance => 1)
Route.create(:vector_a => endor, :vector_b => hoth, :distance => 1)
Route.create(:vector_a => bespin, :vector_b => hoth, :distance => 1)
Route.create(:vector_a => bespin, :vector_b => endor, :distance => 1)
Route.create(:vector_a => eriadu, :vector_b => naboo, :distance => 1)
Route.create(:vector_a => bespin, :vector_b => eriadu, :distance => 1)
Route.create(:vector_a => geonosis, :vector_b => naboo, :distance => 1)
Route.create(:vector_a => geonosis, :vector_b => ryloth, :distance => 1)
Route.create(:vector_a => geonosis, :vector_b => tatooine, :distance => 1)
Route.create(:vector_a => naboo, :vector_b => tatooine, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => naboo, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => tatooine, :distance => 1)
Route.create(:vector_a => bothauwi, :vector_b => tatooine, :distance => 1)
Route.create(:vector_a => bespin, :vector_b => corellia, :distance => 1)
Route.create(:vector_a => bothauwi, :vector_b => corellia, :distance => 1)
Route.create(:vector_a => bothauwi, :vector_b => nalhutta, :distance => 1)
Route.create(:vector_a => kamino, :vector_b => nalhutta, :distance => 1)
Route.create(:vector_a => kashyyyk, :vector_b => nalhutta, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => kuat, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => kuat, :distance => 1)
Route.create(:vector_a => alderaan, :vector_b => corellia, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => coruscant, :distance => 1)
Route.create(:vector_a => kashyyyk, :vector_b => kuat, :distance => 1)
Route.create(:vector_a => byss, :vector_b => coruscant, :distance => 1)
Route.create(:vector_a => alderaan, :vector_b => coruscant, :distance => 1)
Route.create(:vector_a => coruscant, :vector_b => ilum, :distance => 1)
Route.create(:vector_a => coruscant, :vector_b => mygeeto, :distance => 1)
Route.create(:vector_a => ilum, :vector_b => mygeeto, :distance => 1)
Route.create(:vector_a => alderaan, :vector_b => mandalore, :distance => 1)
Route.create(:vector_a => mandalore, :vector_b => mygeeto, :distance => 1)
Route.create(:vector_a => dantooine, :vector_b => mygeeto, :distance => 1)
Route.create(:vector_a => dantooine, :vector_b => yavin, :distance => 1)
Route.create(:vector_a => mandalore, :vector_b => yavin, :distance => 1)
Route.create(:vector_a => felucia, :vector_b => yavin, :distance => 1)
Route.create(:vector_a => felucia, :vector_b => kashyyyk, :distance => 1)
Route.create(:vector_a => felucia, :vector_b => moncalamari, :distance => 1)

all = ['empire','rebel','mercenary','mandalorian']
emp = ['empire']
reb = ['rebel']
merc = ['mercenary']
mand = ['mandalorian']
emp_reb = ['empire','rebel']
merc_reb = ['mercenary','rebel']

Unit.create(:name => 'X-Wing', :price => 275 ).factions = reb
Unit.create(:name => 'Y-Wing', :price => 250 ).factions = reb
Unit.create(:name => 'A-Wing', :price => 350 ).factions = reb
Unit.create(:name => 'B-Wing', :price => 500 ).factions = reb
Unit.create(:name => 'T-Wing', :price => 130 ).factions = reb
Unit.create(:name => 'Z-95', :price => 130 ).factions = merc_reb
Unit.create(:name => 'Skipray Blastboat', :price => 400 ).factions = merc
Unit.create(:name => 'R-41 Starchaser', :price => 200 ).factions = merc
Unit.create(:name => 'Firespray', :price => 275 ).factions = mand
Unit.create(:name => 'Pursuer', :price => 275 ).factions = mand
Unit.create(:name => 'Star Viper', :price => 300 ).factions = mand
Unit.create(:name => 'Cloackshape Fighter', :price => 200 ).factions = merc
Unit.create(:name => 'Razor Fighter', :price => 225 ).factions = merc
Unit.create(:name => 'Planetary Fighter', :price => 200 ).factions = merc
Unit.create(:name => 'Supa Fighter', :price => 250 ).factions = merc
Unit.create(:name => 'Pinook Fighter', :price => 120 ).factions = merc
Unit.create(:name => 'Preybird Fighter', :price => 150 ).factions = merc
Unit.create(:name => 'Tie Fighter', :price => 60 ).factions = emp
Unit.create(:name => 'Tie Bomber', :price => 70 ).factions = emp
Unit.create(:name => 'Tie Interceptor', :price => 80 ).factions = emp
Unit.create(:name => 'Tie Advanced', :price => 425 ).factions = emp
Unit.create(:name => 'Tie Defender', :price => 1200 ).factions = emp
Unit.create(:name => 'Toscan Fighter', :price => 300 ).factions = emp
Unit.create(:name => 'Missile Boat', :price => 700 ).factions = emp
Unit.create(:name => 'Assault Gunboat', :price => 450 ).factions = emp
Unit.create(:name => 'Authority IRD', :price => 115 ).factions = emp

Unit.create(:name => 'YT-1300', :price => 400 ).factions = merc
Unit.create(:name => 'YT-2000', :price => 1200 ).factions = merc
Unit.create(:name => 'YT-2400', :price => 550 ).factions = mand
Unit.create(:name => 'Millenium Falcon', :price => 1000 ).factions = merc_reb
Unit.create(:name => 'Assault Transport', :price => 800 ).factions = all
Unit.create(:name => 'Escort Transport', :price => 800 ).factions = all
Unit.create(:name => 'Escort Shuttle', :price => 350 ).factions = all
Unit.create(:name => 'Scout Craft', :price => 500 ).factions = all
Unit.create(:name => 'Shuttle', :price => 250 ).factions = all
Unit.create(:name => 'Stormtrooper Transport', :price => 250 ).factions = all
Unit.create(:name => 'System Patrol Craft', :price => 1100 ).factions = emp
Unit.create(:name => 'Assault Shuttle', :price => 700 ).factions = emp

Unit.create(:name => 'Venator Star Destroyer', :price => 9999 ).factions = mand
Unit.create(:name => 'Marauder Corvette', :price => 1600 ).factions = mand
Unit.create(:name => 'Mod Corvette', :price => 800 ).factions = merc
Unit.create(:name => 'Dreadnaught', :price => 2800 ).factions = merc
Unit.create(:name => 'Bulk Cruiser', :price => 1900 ).factions = merc
Unit.create(:name => 'Trade Federation Cruiser', :price => 9999 ).factions = merc
Unit.create(:name => 'Lancer Frigate', :price => 1250 ).factions = all
Unit.create(:name => 'Corellian Gunship', :price => 900 ).factions = all
Unit.create(:name => 'Corellian Corvette', :price => 800 ).factions = all
Unit.create(:name => 'Carrack Cruiser', :price => 1100 ).factions = all
Unit.create(:name => 'Mod Neb B Frigate', :price => 1700 ).factions = emp_reb
Unit.create(:name => 'Nebulon B Frigate', :price => 1100 ).factions = emp_reb
Unit.create(:name => 'Calamari Cruiser', :price => 5000 ).factions = reb
Unit.create(:name => 'Lt Calamari Cruiser', :price => 2000 ).factions = reb
Unit.create(:name => 'Calamari Cruiser II', :price => 5000 ).factions = reb
Unit.create(:name => 'Assault Frigate', :price => 3900 ).factions = reb
Unit.create(:name => 'Strike Cruiser', :price => 1700 ).factions = emp_reb
Unit.create(:name => 'Escort Carrier', :price => 1600 ).factions = emp
Unit.create(:name => 'Interdictor', :price => 5000 ).factions = emp
Unit.create(:name => 'Victory Star Destroyer', :price => 5200 ).factions = emp
Unit.create(:name => 'Victory Star Destroyer II', :price => 5700 ).factions = emp
Unit.create(:name => 'Imperial Star Destroyer', :price => 6100 ).factions = emp
Unit.create(:name => 'Imperial Star Destroyer II', :price => 6500 ).factions = emp
Unit.create(:name => 'Super Star Destroyer', :price => 30000 ).factions = emp

Unit.create(:name => 'Mag Pulse Torpedo', :price => 200 ).factions = all
Unit.create(:name => 'Ion Pulse Torpedo', :price => 125 ).factions = reb
Unit.create(:name => 'Concussion Missile', :price => 100 ).factions = all
Unit.create(:name => 'Proton Torpedo', :price => 125 ).factions = all
Unit.create(:name => 'Adv Missile', :price => 200 ).factions = all
Unit.create(:name => 'Adv Torpedo', :price => 250 ).factions = all
Unit.create(:name => 'Heavy Rocket', :price => 500 ).factions = all
Unit.create(:name => 'Space Bomb', :price => 700 ).factions = all

Unit.create(:name => 'Chaff', :price => 25 ).factions = all
Unit.create(:name => 'Flare', :price => 125 ).factions = all

Facility.create(:name => 'Industrial Complex', :price => 3000 ).factions = all
Facility.create(:name => 'Pirate Shipyard', :price => 3000 ).factions = all
Facility.create(:name => 'Space Colony I', :price => 3750 ).factions = all
Facility.create(:name => 'Factory', :price => 6000 ).factions = all
Facility.create(:name => 'Platforms', :price => 6750 ).factions = all
Facility.create(:name => 'Golan I', :price => 7500 ).factions = all
Facility.create(:name => 'Golan II', :price => 9000 ).factions = all
Facility.create(:name => 'Golan II', :price => 10500 ).factions = all
Facility.create(:name => 'Shipyard', :price => 10500 ).factions = all

Trooper.create(:name => 'Stormtrooper', :price => 5 ).factions = emp
Trooper.create(:name => 'Trooper', :price => 5 ).factions = all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
    
