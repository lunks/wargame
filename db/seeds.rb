alderaan = Planet.create(:name => 'Alderaan', :credits => 300 )
bespin = Planet.create(:name => 'Bespin', :credits => 400 )
bothauwi = Planet.create(:name => 'Bothauwi', :credits => 300 )
byss = Planet.create(:name => 'Byss', :credits => 100 )
corellia = Planet.create(:name => 'Corellia', :credits => 500 )
coruscant = Planet.create(:name => 'Coruscant', :credits => 500 )
dagobah = Planet.create(:name => 'Dagobah', :credits => 300 )
dantooine = Planet.create(:name => 'Dantooine', :credits => 200 )
endor = Planet.create(:name => 'Endor', :credits => 200 )
eriadu = Planet.create(:name => 'Eriadu', :credits => 500 )
felucia = Planet.create(:name => 'Felucia', :credits => 300 )
geonosis = Planet.create(:name => 'Geonosis', :credits => 300 )
hoth = Planet.create(:name => 'Hoth', :credits => 400 )
ilum = Planet.create(:name => 'Ilum', :credits => 200 )
kamino = Planet.create(:name => 'Kamino', :credits => 100 )
kashyyyk = Planet.create(:name => 'Kashyyyk', :credits => 300 )
kuat = Planet.create(:name => 'Kuat', :credits => 300 )
mandalore = Planet.create(:name => 'Mandalore', :credits => 300 )
moncalamari = Planet.create(:name => 'Mon Calamari', :credits => 100 )
mustafar = Planet.create(:name => 'Mustafar', :credits => 300 )
mygeeto = Planet.create(:name => 'Mygeeto', :credits => 400 )
naboo = Planet.create(:name => 'Naboo', :credits => 400 )
nalhutta = Planet.create(:name => 'Nal Hutta', :credits => 300 )
polismassa = Planet.create(:name => 'Polis Massa', :credits => 200 )
ryloth = Planet.create(:name => 'Ryloth', :credits => 100 )
tatooine = Planet.create(:name => 'Tatooine', :credits => 300 )
utapau = Planet.create(:name => 'Utapau', :credits => 100 )
yavin = Planet.create(:name => 'Yavin', :credits => 300 )

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
#Route.create(:vector_a => corellia, :vector_b => tatooine, :distance => 1) acertar no mapa
Route.create(:vector_a => bothauwi, :vector_b => tatooine, :distance => 1)
Route.create(:vector_a => bespin, :vector_b => corellia, :distance => 1)
Route.create(:vector_a => bothauwi, :vector_b => corellia, :distance => 1)
Route.create(:vector_a => bothauwi, :vector_b => nalhutta, :distance => 1)
Route.create(:vector_a => kamino, :vector_b => nalhutta, :distance => 1)
Route.create(:vector_a => kashyyyk, :vector_b => nalhutta, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => kuat, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => coruscant, :distance => 1)
Route.create(:vector_a => kashyyyk, :vector_b => kuat, :distance => 1)
Route.create(:vector_a => byss, :vector_b => coruscant, :distance => 1)
Route.create(:vector_a => alderaan, :vector_b => coruscant, :distance => 1)
Route.create(:vector_a => coruscant, :vector_b => ilum, :distance => 1)
Route.create(:vector_a => coruscant, :vector_b => mygeeto, :distance => 1)
Route.create(:vector_a => ilum, :vector_b => mygeeto, :distance => 1)
Route.create(:vector_a => alderaan, :vector_b => mandalore, :distance => 1)
Route.create(:vector_a => alderaan, :vector_b => kuat, :distance => 1)
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

Fighter.create(:name => 'X-Wing', :price => 100).factions = reb
Fighter.create(:name => 'Y-Wing', :price => 100 ).factions = reb
Fighter.create(:name => 'A-Wing', :price => 140 ).factions = reb
Fighter.create(:name => 'B-Wing', :price => 200 ).factions = reb
Fighter.create(:name => 'T-Wing', :price => 50 ).factions = merc_reb
Fighter.create(:name => 'Z-95', :price => 50 ).factions = merc_reb
Fighter.create(:name => 'Droid Fighter', :hyperdrive => false, :price => 35 ).factions = merc
Fighter.create(:name => 'Droid Tri-fighter', :hyperdrive => false, :price => 30 ).factions = merc
Fighter.create(:name => 'Pinook Fighter', :price => 45 ).factions = merc
Fighter.create(:name => 'Preybird Fighter', :price => 60 ).factions = merc
Fighter.create(:name => 'R-41 Starchaser', :price => 80 ).factions = merc
Fighter.create(:name => 'Cloackshape Fighter', :price => 80 ).factions = merc
Fighter.create(:name => 'Planetary Fighter', :price => 80 ).factions = merc
Fighter.create(:name => 'Razor Fighter', :price => 90 ).factions = merc
Fighter.create(:name => 'IG-2000', :price => 170 ).factions = merc
Fighter.create(:name => 'Skipray Blastboat', :price => 135 ).factions = merc
Fighter.create(:name => 'Supa Fighter', :price => 90 ).factions = mand
Fighter.create(:name => 'Firespray', :price => 120 ).factions = mand
Fighter.create(:name => 'Pursuer', :price => 100 ).factions = mand
Fighter.create(:name => 'Star Viper', :price => 120 ).factions = mand
Fighter.create(:name => 'V-Wing', :hyperdrive => false, :price => 50 ).factions = mand
Fighter.create(:name => 'ARC-170', :price => 100 ).factions = mand
Fighter.create(:name => 'Tie Fighter', :hyperdrive => false, :price => 25 ).factions = imp
Fighter.create(:name => 'Tie Bomber', :hyperdrive => false, :price => 30 ).factions = imp
Fighter.create(:name => 'Tie Interceptor', :hyperdrive => false, :price => 30 ).factions = imp
Fighter.create(:name => 'Tie Avenger', :price => 150 ).factions = imp
Fighter.create(:name => 'Authority IRD', :hyperdrive => false, :price => 40 ).factions = imp
Fighter.create(:name => 'Toscan Fighter', :price => 120 ).factions = imp
Fighter.create(:name => 'Tie Advanced X1', :price => 130 ).factions = imp
Fighter.create(:name => 'Assault Gunboat', :price => 180 ).factions = imp
Fighter.create(:name => 'Missile Boat', :price => 220 ).factions = imp
Fighter.create(:name => 'Tie Phantom', :price => 200 ).factions = imp
Fighter.create(:name => 'Tie Defender', :price => 400 ).factions = imp

LightTransport.create(:name => 'YT-1300', :price => 140 ).factions = merc
LightTransport.create(:name => 'YT-2000', :price => 430 ).factions = merc
LightTransport.create(:name => 'YT-2400', :price => 190 ).factions = mand
LightTransport.create(:name => 'Millenium Falcon', :price => 350 ).factions = merc_reb

LightTransport.create(:name => 'Assault Transport', :price => 300 ).factions = all
LightTransport.create(:name => 'Escort Transport', :price => 300 ).factions = all
LightTransport.create(:name => 'Escort Shuttle', :price => 135 ).factions = all
LightTransport.create(:name => 'Scout Craft', :price => 190 ).factions = all
LightTransport.create(:name => 'Shuttle', :price => 90 ).factions = all
LightTransport.create(:name => 'Stormtrooper Transport', :price => 90 ).factions = all
LightTransport.create(:name => 'System Patrol Craft', :price => 430 ).factions = imp
LightTransport.create(:name => 'Assault Shuttle', :price => 260 ).factions = imp

#CapitalShip.create(:name => 'Alliance Escort Carrier', :price => 550 ).factions = reb
CapitalShip.create(:name => 'Reef Home Calamari Cruiser', :price => 2200 ).factions = reb
CapitalShip.create(:name => 'Lt Calamari Cruiser', :price => 850 ).factions = reb
CapitalShip.create(:name => 'Liberty Calamari Cruiser', :price => 2200 ).factions = reb
CapitalShip.create(:name => 'Assault Frigate', :price => 1700 ).factions = reb
CapitalShip.create(:name => 'Liberator Cruiser', :price => 2450 ).factions = reb
CapitalShip.create(:name => 'Dauntless Cruiser', :price => 2850 ).factions = reb
CapitalShip.create(:name => 'Bulkwark Cruiser', :price => 12000 ).factions = reb
CapitalShip.create(:name => 'Mod Corvette', :price => 430 ).factions = merc
CapitalShip.create(:name => 'Marauder Corvette', :price => 850 ).factions = mand_merc
CapitalShip.create(:name => 'Providence Destroyer', :price => 2200 ).factions = merc
CapitalShip.create(:name => 'Munificent Frigate', :price => 2000 ).factions = merc
CapitalShip.create(:name => 'Dreadnaught', :price => 1250 ).factions = all
CapitalShip.create(:name => 'Bulk Cruiser', :price => 1000 ).factions = merc
CapitalShip.create(:name => 'Lancer Frigate', :price => 570 ).factions = imp
CapitalShip.create(:name => 'Corellian Gunship', :price => 430 ).factions = all
CapitalShip.create(:name => 'Corellian Corvette', :price => 380 ).factions = all
CapitalShip.create(:name => 'Carrack Cruiser', :price => 470 ).factions = imp
CapitalShip.create(:name => 'Nebulon B2 Frigate', :price => 700 ).factions = imp_reb
CapitalShip.create(:name => 'Nebulon B Frigate', :price => 470 ).factions = imp_reb
CapitalShip.create(:name => 'Strike Cruiser', :price => 800 ).factions = imp_reb
#CapitalShip.create(:name => 'Radiant VII Cruiser', :price => 500 ).factions = mand
CapitalShip.create(:name => 'Venator Star Destroyer', :price => 2300 ).factions = mand
CapitalShip.create(:name => 'Acclamator Assault Ship', :price => 2100 ).factions = mand
CapitalShip.create(:name => 'Lucrehulk Battleship', :price => 8000 ).factions = mand_merc
CapitalShip.create(:name => 'Escort Carrier', :price => 750 ).factions = imp
CapitalShip.create(:name => 'Interdictor', :price => 2400 ).factions = imp
CapitalShip.create(:name => 'Victory Star Destroyer', :price => 2250 ).factions = imp
CapitalShip.create(:name => 'Victory Star Destroyer II', :price => 2500 ).factions = imp
CapitalShip.create(:name => 'Imperial Star Destroyer', :price => 2700 ).factions = imp
CapitalShip.create(:name => 'Imperial Star Destroyer II', :price => 2900 ).factions = imp
CapitalShip.create(:name => 'Dominator Interdictor', :price => 3600 ).factions = imp
CapitalShip.create(:name => 'Super Star Destroyer', :price => 13750 ).factions = imp

Armament.create(:name => 'Mag Pulse Torpedo', :price => 40 ).factions = all
Armament.create(:name => 'Ion Pulse Torpedo', :price => 30 ).factions = reb
Armament.create(:name => 'Concussion Missile', :price => 25 ).factions = all
Armament.create(:name => 'Proton Torpedo', :price => 25 ).factions = all
Armament.create(:name => 'Adv Missile', :price => 35 ).factions = all
Armament.create(:name => 'Adv Torpedo', :price => 45 ).factions = all
Armament.create(:name => 'Heavy Rocket', :price => 100 ).factions = all
Armament.create(:name => 'Space Bomb', :price => 120 ).factions = all

Armament.create(:name => 'Chaff', :price => 5 ).factions = all
Armament.create(:name => 'Flare', :price => 35 ).factions = all

Trooper.create(:name => 'Trooper', :price => 2 ).factions = all

Facility.create(:name => 'Rebel Platform', :price => 2900 ).factions = reb
Facility.create(:name => 'Asteroid Hangar', :price => 2600 ).factions = mand_merc
Facility.create(:name => 'Derilyn Platform', :price => 1400 ).factions = mand_merc
Facility.create(:name => 'Family Base', :price => 1700 ).factions = merc
Facility.create(:name => 'Cargo Facility I', :price => 1200 ).factions = all
Facility.create(:name => 'Cargo Facility II', :price => 2000 ).factions = all
Facility.create(:name => 'Industrial Complex', :price => 1000 ).factions = all
Facility.create(:name => 'Factory', :price => 1900 ).factions = all
Facility.create(:name => 'Golan I', :price => 2400 ).factions = all
Facility.create(:name => 'Golan II', :price => 4300 ).factions = all
Facility.create(:name => 'Golan III', :price => 5700 ).factions = all
Facility.create(:name => 'Platforms', :price => 2000 ).factions = all
Facility.create(:name => 'Imperial Research Center', :price => 4800 ).factions = imp
Facility.create(:name => 'Shipyard', :price => 6000 ).factions = all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
    
