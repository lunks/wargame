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
geonosis = Planet.create(:name => 'Geonosis' , :credits =>  800 )
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

imp = ['empire']
reb = ['rebel']
imp_reb = ['empire','rebel']
merc = ['mercenary']
merc_reb = ['mercenary','rebel']
mand = ['mandalorian']
mand_merc = ['mandalorian','mercenary']
all = ['empire','rebel','mercenary','mandalorian']

Unit.create(:name => 'X-Wing', :price => 250).factions = reb
Unit.create(:name => 'Y-Wing', :price => 250 ).factions = reb
Unit.create(:name => 'A-Wing', :price => 350 ).factions = reb
Unit.create(:name => 'B-Wing', :price => 475 ).factions = reb
Unit.create(:name => 'T-Wing', :price => 130 ).factions = merc_reb
Unit.create(:name => 'Z-95', :price => 130 ).factions = merc_reb
Unit.create(:name => 'Droid Fighter', :price => 90 ).factions = merc
Unit.create(:name => 'Droid Tri-fighter', :price => 80 ).factions = merc
Unit.create(:name => 'Pinook Fighter', :price => 120 ).factions = merc
Unit.create(:name => 'Preybird Fighter', :price => 150 ).factions = merc
Unit.create(:name => 'R-41 Starchaser', :price => 200 ).factions = merc
Unit.create(:name => 'Cloackshape Fighter', :price => 200 ).factions = merc
Unit.create(:name => 'Planetary Fighter', :price => 200 ).factions = merc
Unit.create(:name => 'Razor Fighter', :price => 225 ).factions = merc
Unit.create(:name => 'IG-2000', :price => 550 ).factions = merc
Unit.create(:name => 'Skipray Blastboat', :price => 350 ).factions = merc
Unit.create(:name => 'Supa Fighter', :price => 250 ).factions = mand
Unit.create(:name => 'Firespray', :price => 300 ).factions = mand
Unit.create(:name => 'Pursuer', :price => 275 ).factions = mand
Unit.create(:name => 'Star Viper', :price => 300 ).factions = mand
Unit.create(:name => 'V-Wing', :price => 150 ).factions = mand
Unit.create(:name => 'ARC-170', :price => 250 ).factions = mand
Unit.create(:name => 'Tie Fighter', :price => 60 ).factions = imp
Unit.create(:name => 'Tie Bomber', :price => 70 ).factions = imp
Unit.create(:name => 'Tie Interceptor', :price => 90 ).factions = imp
Unit.create(:name => 'Tie Avenger', :price => 400 ).factions = imp
Unit.create(:name => 'Authority IRD', :price => 115 ).factions = imp
Unit.create(:name => 'Toscan Fighter', :price => 300 ).factions = imp
Unit.create(:name => 'Tie Advanced X1', :price => 400 ).factions = imp
Unit.create(:name => 'Assault Gunboat', :price => 450 ).factions = imp
Unit.create(:name => 'Missile Boat', :price => 500 ).factions = imp
Unit.create(:name => 'Tie Phantom', :price => 500 ).factions = imp
Unit.create(:name => 'Tie Defender', :price => 1000 ).factions = imp

Unit.create(:name => 'YT-1300', :price => 375 ).factions = merc
Unit.create(:name => 'YT-2000', :price => 1100 ).factions = merc
Unit.create(:name => 'YT-2400', :price => 500 ).factions = mand
Unit.create(:name => 'Millenium Falcon', :price => 900 ).factions = merc_reb

LightTransport.create(:name => 'Assault Transport', :price => 800 ).factions = all
LightTransport.create(:name => 'Escort Transport', :price => 800 ).factions = all
LightTransport.create(:name => 'Escort Shuttle', :price => 350 ).factions = all
LightTransport.create(:name => 'Scout Craft', :price => 500 ).factions = all
LightTransport.create(:name => 'Shuttle', :price => 250 ).factions = all
LightTransport.create(:name => 'Stormtrooper Transport', :price => 250 ).factions = all
LightTransport.create(:name => 'System Patrol Craft', :price => 1100 ).factions = imp
LightTransport.create(:name => 'Assault Shuttle', :price => 700 ).factions = imp

CapitalShip.create(:name => 'Alliance Escort Carrier', :price => 1400 ).factions = reb
CapitalShip.create(:name => 'Reef Home Calamari Cruiser', :price => 5500 ).factions = reb
CapitalShip.create(:name => 'Lt Calamari Cruiser', :price => 2200 ).factions = reb
CapitalShip.create(:name => 'Liberty Calamari Cruiser', :price => 5500 ).factions = reb
CapitalShip.create(:name => 'Assault Frigate', :price => 4300 ).factions = reb
CapitalShip.create(:name => 'Liberator Cruiser', :price => 6200 ).factions = reb
CapitalShip.create(:name => 'Dauntless Cruiser', :price => 7200 ).factions = reb
CapitalShip.create(:name => 'Bulkwark Cruiser', :price => 30000 ).factions = reb
CapitalShip.create(:name => 'Mod Corvette', :price => 1000 ).factions = merc
CapitalShip.create(:name => 'Marauder Corvette', :price => 2100 ).factions = merc
CapitalShip.create(:name => 'Providence Destroyer', :price => 5600 ).factions = merc
CapitalShip.create(:name => 'Munificent Frigate', :price => 5200 ).factions = merc
CapitalShip.create(:name => 'Marauder Corvette', :price => 2200 ).factions = merc
CapitalShip.create(:name => 'Dreadnaught', :price => 3200 ).factions = all
CapitalShip.create(:name => 'Bulk Cruiser', :price => 2600 ).factions = merc
CapitalShip.create(:name => 'Lancer Frigate', :price => 1400 ).factions = imp
CapitalShip.create(:name => 'Corellian Gunship', :price => 1100 ).factions = all
CapitalShip.create(:name => 'Corellian Corvette', :price => 1000 ).factions = all
CapitalShip.create(:name => 'Carrack Cruiser', :price => 1200 ).factions = imp
CapitalShip.create(:name => 'Mod Neb B Frigate', :price => 1800 ).factions = imp_reb
CapitalShip.create(:name => 'Nebulon B Frigate', :price => 1200 ).factions = imp_reb
CapitalShip.create(:name => 'Strike Cruiser', :price => 2000 ).factions = imp_reb
CapitalShip.create(:name => 'Radiant IV Cruiser', :price => 1300 ).factions = mand
CapitalShip.create(:name => 'Venator Star Destroyer', :price => 5800 ).factions = mand
CapitalShip.create(:name => 'Acclamator Assault Ship', :price => 5400 ).factions = mand
CapitalShip.create(:name => 'Lucrehulk Battleship', :price => 20000 ).factions = mand_merc
CapitalShip.create(:name => 'Escort Carrier', :price => 1900 ).factions = imp
CapitalShip.create(:name => 'Interdictor', :price => 6000 ).factions = imp
CapitalShip.create(:name => 'Victory Star Destroyer', :price => 5700 ).factions = imp
CapitalShip.create(:name => 'Victory Star Destroyer II', :price => 6300 ).factions = imp
CapitalShip.create(:name => 'Imperial Star Destroyer', :price => 6700 ).factions = imp
CapitalShip.create(:name => 'Imperial Star Destroyer II', :price => 7200 ).factions = imp
CapitalShip.create(:name => 'Dominator Interdictor', :price => 8800 ).factions = imp
CapitalShip.create(:name => 'Super Star Destroyer', :price => 35000 ).factions = imp

Armament.create(:name => 'Mag Pulse Torpedo', :price => 150 ).factions = all
Armament.create(:name => 'Ion Pulse Torpedo', :price => 75 ).factions = reb
Armament.create(:name => 'Concussion Missile', :price => 75 ).factions = all
Armament.create(:name => 'Proton Torpedo', :price => 75 ).factions = all
Armament.create(:name => 'Adv Missile', :price => 125 ).factions = all
Armament.create(:name => 'Adv Torpedo', :price => 150 ).factions = all
Armament.create(:name => 'Heavy Rocket', :price => 250 ).factions = all
Armament.create(:name => 'Space Bomb', :price => 400 ).factions = all

Armament.create(:name => 'Chaff', :price => 25 ).factions = all
Armament.create(:name => 'Flare', :price => 125 ).factions = all

Trooper.create(:name => 'Trooper', :price => 5 ).factions = all

Facility.create(:name => 'Factory', :price => 6000 ).factions = all
Facility.create(:name => 'Golan I', :price => 7500 ).factions = all
Facility.create(:name => 'Golan II', :price => 9000 ).factions = all
Facility.create(:name => 'Industrial Complex', :price => 3000 ).factions = all
Facility.create(:name => 'Shipyard', :price => 10500 ).factions = all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
    
