alderaan_graveyard = Planet.create(:name => 'Alderaan Graveyard', :credits => 400 )
bespin = Planet.create(:name => 'Bespin', :credits => 400 )
brnavies_spaceport = Planet.create(:name => 'BrNavies Spaceport', :credits => 400 )
cimf_station = Planet.create(:name => 'CIMF Station', :credits => 400 )
concord_dawn = Planet.create(:name => 'Concord Dawn', :credits => 400 )
corellia = Planet.create(:name => 'Corellia', :credits => 400 )
coruscant = Planet.create(:name => 'Coruscant', :credits => 400 )
dagobah = Planet.create(:name => 'Dagobah', :credits => 400 )
dantooine = Planet.create(:name => 'Dantooine', :credits => 400 )
endor = Planet.create(:name => 'Endor', :credits => 400 )
felucia = Planet.create(:name => 'Felucia', :credits => 400 )
geonosis = Planet.create(:name => 'Geonosis', :credits => 400 )
haruun_kal = Planet.create(:name => 'Haruun Kal', :credits => 400 )
hoth = Planet.create(:name => 'Hoth', :credits => 400 )
hutt_space = Planet.create(:name => 'Hutts Minefields', :credits => 400 )
ilum = Planet.create(:name => 'Ilum', :credits => 400 )
kamino = Planet.create(:name => 'Kamino', :credits => 400 )
kashyyyk = Planet.create(:name => 'Kashyyyk', :credits => 400 )
katarr_supernova = Planet.create(:name => 'Katarr Supernova', :credits => 400 )
kessel_asteroids = Planet.create(:name => 'Kessel Asteroids', :credits => 400 )
kuat = Planet.create(:name => 'Kuat', :credits => 400 )
mandalore = Planet.create(:name => 'Mandalore', :credits => 400 )
mon_calamari = Planet.create(:name => 'Mon Calamari', :credits => 400 )
mustafar = Planet.create(:name => 'Mustafar', :credits => 400 )
mygeeto = Planet.create(:name => 'Mygeeto', :credits => 400 )
naboo = Planet.create(:name => 'Naboo', :credits => 400 )
nal_hutta = Planet.create(:name => 'Nal Hutta', :credits => 400 )
ord_ibanna = Planet.create(:name => 'Ord Ibanna', :credits => 400 )
polis_massa = Planet.create(:name => 'Polis Massa', :credits => 400 )
rattatak = Planet.create(:name => 'Rattatak', :credits => 400 )
red_twins_system = Planet.create(:name => 'Deadalis Minefields', :credits => 400 )
rhen_var = Planet.create(:name => 'Rhen Var', :credits => 400 )
silken_asteroids = Planet.create(:name => 'Silken Asteroids', :credits => 400 )
tatooine = Planet.create(:name => 'Tatooine', :credits => 400 )
utapau = Planet.create(:name => 'Utapau', :credits => 400 )
vergesso_asteroids = Planet.create(:name => 'Vergesso Asteroids', :credits => 400 )
yavin = Planet.create(:name => 'Yavin', :credits => 400 )

Route.create(:vector_a => dantooine, :vector_b => katarr_supernova, :distance => 1)
Route.create(:vector_a => dantooine, :vector_b => mandalore, :distance => 1)
Route.create(:vector_a => dantooine, :vector_b => yavin, :distance => 1)

Route.create(:vector_a => yavin, :vector_b => mandalore, :distance => 1)
Route.create(:vector_a => yavin, :vector_b => rhen_var, :distance => 1)

Route.create(:vector_a => ilum, :vector_b => rattatak, :distance => 1)
Route.create(:vector_a => ilum, :vector_b => red_twins_system, :distance => 1)
Route.create(:vector_a => ilum, :vector_b => mygeeto, :distance => 1)

Route.create(:vector_a => mygeeto, :vector_b => red_twins_system, :distance => 1)
Route.create(:vector_a => mygeeto, :vector_b => coruscant, :distance => 1)
Route.create(:vector_a => mygeeto, :vector_b => katarr_supernova, :distance => 1)

Route.create(:vector_a => katarr_supernova, :vector_b => coruscant, :distance => 1)
Route.create(:vector_a => katarr_supernova, :vector_b => alderaan_graveyard, :distance => 1)
Route.create(:vector_a => katarr_supernova, :vector_b => mandalore, :distance => 1)

Route.create(:vector_a => mandalore, :vector_b => alderaan_graveyard, :distance => 1)
Route.create(:vector_a => mandalore, :vector_b => concord_dawn, :distance => 1)
Route.create(:vector_a => mandalore, :vector_b => rhen_var, :distance => 1)

Route.create(:vector_a => rhen_var, :vector_b => concord_dawn, :distance => 1)
Route.create(:vector_a => rhen_var, :vector_b => felucia, :distance => 1)

Route.create(:vector_a => rattatak, :vector_b => endor, :distance => 1)
Route.create(:vector_a => rattatak, :vector_b => red_twins_system, :distance => 1)

Route.create(:vector_a => red_twins_system, :vector_b => endor, :distance => 1)
Route.create(:vector_a => red_twins_system, :vector_b => bespin, :distance => 1)
Route.create(:vector_a => red_twins_system, :vector_b => coruscant, :distance => 1)

Route.create(:vector_a => coruscant, :vector_b => bespin, :distance => 1)
Route.create(:vector_a => coruscant, :vector_b => corellia, :distance => 1)
Route.create(:vector_a => coruscant, :vector_b => alderaan_graveyard, :distance => 1)

Route.create(:vector_a => alderaan_graveyard, :vector_b => corellia, :distance => 1)
Route.create(:vector_a => alderaan_graveyard, :vector_b => kuat, :distance => 1)
Route.create(:vector_a => alderaan_graveyard, :vector_b => concord_dawn, :distance => 1)

Route.create(:vector_a => concord_dawn, :vector_b => kuat, :distance => 1)
Route.create(:vector_a => concord_dawn, :vector_b => kashyyyk, :distance => 1)
Route.create(:vector_a => concord_dawn, :vector_b => felucia, :distance => 1)

Route.create(:vector_a => felucia, :vector_b => kashyyyk, :distance => 1)
Route.create(:vector_a => felucia, :vector_b => kessel_asteroids, :distance => 1)
Route.create(:vector_a => felucia, :vector_b => mon_calamari, :distance => 1)

Route.create(:vector_a => mon_calamari, :vector_b => kessel_asteroids, :distance => 1)

Route.create(:vector_a => endor, :vector_b => brnavies_spaceport, :distance => 1)
Route.create(:vector_a => endor, :vector_b => hoth, :distance => 1)
Route.create(:vector_a => endor, :vector_b => bespin, :distance => 1)

Route.create(:vector_a => bespin, :vector_b => hoth, :distance => 1)
Route.create(:vector_a => bespin, :vector_b => haruun_kal, :distance => 1)
Route.create(:vector_a => bespin, :vector_b => corellia, :distance => 1)

Route.create(:vector_a => corellia, :vector_b => haruun_kal, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => cimf_station, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => kuat, :distance => 1)

Route.create(:vector_a => kuat, :vector_b => cimf_station, :distance => 1)
Route.create(:vector_a => kuat, :vector_b => nal_hutta, :distance => 1)
Route.create(:vector_a => kuat, :vector_b => kashyyyk, :distance => 1)

Route.create(:vector_a => kashyyyk, :vector_b => nal_hutta, :distance => 1)
Route.create(:vector_a => kashyyyk, :vector_b => hutt_space, :distance => 1)
Route.create(:vector_a => kashyyyk, :vector_b => kessel_asteroids, :distance => 1)

Route.create(:vector_a => kessel_asteroids, :vector_b => hutt_space, :distance => 1)
Route.create(:vector_a => kessel_asteroids, :vector_b => kamino, :distance => 1)

Route.create(:vector_a => brnavies_spaceport, :vector_b => mustafar, :distance => 1)
Route.create(:vector_a => brnavies_spaceport, :vector_b => hoth, :distance => 1)

Route.create(:vector_a => hoth, :vector_b => mustafar, :distance => 1)
Route.create(:vector_a => hoth, :vector_b => ord_ibanna, :distance => 1)
Route.create(:vector_a => hoth, :vector_b => haruun_kal, :distance => 1)

Route.create(:vector_a => haruun_kal, :vector_b => ord_ibanna, :distance => 1)
Route.create(:vector_a => haruun_kal, :vector_b => naboo, :distance => 1)
Route.create(:vector_a => haruun_kal, :vector_b => cimf_station, :distance => 1)

Route.create(:vector_a => cimf_station, :vector_b => naboo, :distance => 1)
Route.create(:vector_a => cimf_station, :vector_b => vergesso_asteroids, :distance => 1)
Route.create(:vector_a => cimf_station, :vector_b => nal_hutta, :distance => 1)

Route.create(:vector_a => nal_hutta, :vector_b => vergesso_asteroids, :distance => 1)
Route.create(:vector_a => nal_hutta, :vector_b => tatooine, :distance => 1)
Route.create(:vector_a => nal_hutta, :vector_b => hutt_space, :distance => 1)

Route.create(:vector_a => hutt_space, :vector_b => tatooine, :distance => 1)
Route.create(:vector_a => hutt_space, :vector_b => kamino, :distance => 1)

Route.create(:vector_a => mustafar, :vector_b => polis_massa, :distance => 1)
Route.create(:vector_a => mustafar, :vector_b => dagobah, :distance => 1)
Route.create(:vector_a => mustafar, :vector_b => ord_ibanna, :distance => 1)

Route.create(:vector_a => ord_ibanna, :vector_b => dagobah, :distance => 1)
Route.create(:vector_a => ord_ibanna, :vector_b => silken_asteroids, :distance => 1)
Route.create(:vector_a => ord_ibanna, :vector_b => naboo, :distance => 1)

Route.create(:vector_a => naboo, :vector_b => silken_asteroids, :distance => 1)
Route.create(:vector_a => naboo, :vector_b => utapau, :distance => 1)
Route.create(:vector_a => naboo, :vector_b => vergesso_asteroids, :distance => 1)

Route.create(:vector_a => vergesso_asteroids, :vector_b => utapau, :distance => 1)
Route.create(:vector_a => vergesso_asteroids, :vector_b => tatooine, :distance => 1)
Route.create(:vector_a => vergesso_asteroids, :vector_b => geonosis, :distance => 1)

Route.create(:vector_a => tatooine, :vector_b => geonosis, :distance => 1)

Route.create(:vector_a => polis_massa, :vector_b => dagobah, :distance => 1)

Route.create(:vector_a => dagobah, :vector_b => silken_asteroids, :distance => 1)

Route.create(:vector_a => silken_asteroids, :vector_b => utapau, :distance => 1)

Route.create(:vector_a => geonosis, :vector_b => utapau, :distance => 1)

imp = ['empire']
reb = ['rebel']
imp_reb = ['empire','rebel']
merc = ['mercenary']
merc_reb = ['mercenary','rebel']
mand = ['mandalorian']
mand_merc = ['mandalorian','mercenary']
all = ['empire','rebel','mercenary','mandalorian']

Fighter.create(:name => 'Inactive', :price => 99999 ).factions = all
Fighter.create(:name => 'Z-95', :price => 50 ).factions = merc_reb
Fighter.create(:name => 'T-Wing', :price => 50 ).factions = merc_reb
Fighter.create(:name => 'Y-Wing', :price => 90 ).factions = reb
Fighter.create(:name => 'X-Wing', :price => 100).factions = reb
Fighter.create(:name => 'A-Wing', :price => 140 ).factions = reb
Fighter.create(:name => 'B-Wing', :price => 180 ).factions = reb
Fighter.create(:name => 'Droid Fighter*', :hyperdrive => false, :price => 30 ).factions = merc
Fighter.create(:name => 'Droid Tri-fighter*', :hyperdrive => false, :price => 45 ).factions = merc
Fighter.create(:name => 'Pinook Fighter', :price => 45 ).factions = merc
Fighter.create(:name => 'Preybird Fighter', :price => 60 ).factions = merc
Fighter.create(:name => 'Cloackshape Fighter', :price => 70 ).factions = merc
Fighter.create(:name => 'Planetary Fighter', :price => 70 ).factions = merc
Fighter.create(:name => 'R-41 Starchaser', :price => 80 ).factions = merc
Fighter.create(:name => 'Razor Fighter', :price => 90 ).factions = merc
Fighter.create(:name => 'Skipray Blastboat', :price => 130 ).factions = merc
Fighter.create(:name => 'V-Wing*', :hyperdrive => false, :price => 40 ).factions = mand
Fighter.create(:name => 'Supa Fighter', :price => 90 ).factions = mand
Fighter.create(:name => 'ARC-170', :price => 100 ).factions = mand
Fighter.create(:name => 'Pursuer', :price => 100 ).factions = mand
Fighter.create(:name => 'Firespray', :price => 120 ).factions = mand
Fighter.create(:name => 'Star Viper', :price => 120 ).factions = mand
Fighter.create(:name => 'Tie Fighter*', :hyperdrive => false, :price => 25 ).factions = imp
Fighter.create(:name => 'Tie Bomber*', :hyperdrive => false, :price => 30 ).factions = imp
Fighter.create(:name => 'Tie Interceptor*', :hyperdrive => false, :price => 35 ).factions = imp
Fighter.create(:name => 'Authority IRD*', :hyperdrive => false, :price => 55 ).factions = imp
Fighter.create(:name => 'Toscan Fighter', :price => 110 ).factions = imp
Fighter.create(:name => 'Tie Avenger', :price => 140 ).factions = imp
Fighter.create(:name => 'Assault Gunboat', :price => 150 ).factions = imp
Fighter.create(:name => 'Tie Phantom', :price => 180 ).factions = imp
Fighter.create(:name => 'Missile Boat', :price => 280 ).factions = imp
Fighter.create(:name => 'Tie Defender', :price => 400 ).factions = imp

LightTransport.create(:name => 'YT-1300', :price => 140 ).factions = merc
LightTransport.create(:name => 'YT-2000', :price => 400 ).factions = merc
LightTransport.create(:name => 'YT-2400', :price => 180 ).factions = mand
LightTransport.create(:name => 'Millenium Falcon', :price => 340 ).factions = merc_reb

LightTransport.create(:name => 'Assault Transport', :price => 250 ).factions = all
LightTransport.create(:name => 'Escort Transport', :price => 250 ).factions = all
LightTransport.create(:name => 'Stormtrooper Transport', :price => 70 ).factions = all
LightTransport.create(:name => 'Assault Shuttle', :price => 220 ).factions = imp
LightTransport.create(:name => 'System Patrol Craft', :price => 350 ).factions = imp

CapitalShip.create(:name => 'Corellian Gunship', :price => 400 ).factions = all
CapitalShip.create(:name => 'Corellian Corvette', :price => 400 ).factions = all
CapitalShip.create(:name => 'Mod Corvette', :price => 430 ).factions = all
CapitalShip.create(:name => 'Nebulon B Frigate', :price => 500 ).factions = all
CapitalShip.create(:name => 'Nebulon B2 Frigate', :price => 700 ).factions = all
CapitalShip.create(:name => 'Carrack Cruiser', :price => 500 ).factions = imp
CapitalShip.create(:name => 'Lancer Frigate', :price => 550 ).factions = imp
CapitalShip.create(:name => 'Marauder Corvette', :price => 800 ).factions = mand_merc
CapitalShip.create(:name => 'Dreadnaught', :price => 1250 ).factions = all
CapitalShip.create(:name => 'Escort Carrier', :price => 900 ).factions = imp
CapitalShip.create(:name => 'Lt Calamari Cruiser', :price => 900 ).factions = reb
CapitalShip.create(:name => 'Bulk Cruiser', :price => 1000 ).factions = merc
CapitalShip.create(:name => 'Strike Cruiser', :price => 1400 ).factions = imp_reb
CapitalShip.create(:name => 'Assault Frigate', :price => 1700 ).factions = reb
CapitalShip.create(:name => 'Munificent Frigate', :price => 1800 ).factions = merc
CapitalShip.create(:name => 'Acclamator Assault Ship', :price => 1800 ).factions = mand
CapitalShip.create(:name => 'Victory Star Destroyer', :price => 1900 ).factions = imp
CapitalShip.create(:name => 'Venator Star Destroyer', :price => 2000 ).factions = mand
CapitalShip.create(:name => 'Providence Destroyer', :price => 2000 ).factions = merc
CapitalShip.create(:name => 'Reef Home Calamari Cruiser', :price => 2000 ).factions = reb
CapitalShip.create(:name => 'Liberty Calamari Cruiser', :price => 2000 ).factions = reb
CapitalShip.create(:name => 'Victory Star Destroyer II', :price => 2100 ).factions = imp
CapitalShip.create(:name => 'Liberator Cruiser', :price => 2200 ).factions = reb
CapitalShip.create(:name => 'Interdictor', :price => 2500 ).factions = imp
CapitalShip.create(:name => 'Dauntless Cruiser', :price => 2400 ).factions = reb
CapitalShip.create(:name => 'Imperial Star Destroyer', :price => 2450 ).factions = imp
CapitalShip.create(:name => 'Dominator Interdictor', :price => 2800 ).factions = imp
CapitalShip.create(:name => 'Imperial Star Destroyer II', :price => 2800 ).factions = imp
CapitalShip.create(:name => 'Lucrehulk Battleship', :price => 5500 ).factions = mand_merc
CapitalShip.create(:name => 'Bulkwark Cruiser', :price => 7200 ).factions = reb
CapitalShip.create(:name => 'Super Star Destroyer', :price => 8400 ).factions = imp

Armament.create(:name => 'Concussion Missile', :price => 15 ).factions = all
Armament.create(:name => 'Proton Torpedo', :price => 20 ).factions = all
Armament.create(:name => 'Ion Pulse Torpedo', :price => 20 ).factions = reb
Armament.create(:name => 'Adv Missile', :price => 30 ).factions = all
Armament.create(:name => 'Adv Torpedo', :price => 40 ).factions = all
Armament.create(:name => 'Mag Pulse Torpedo', :price => 40 ).factions = all
Armament.create(:name => 'Heavy Rocket', :price => 80 ).factions = all
Armament.create(:name => 'Space Bomb', :price => 100 ).factions = all

Armament.create(:name => 'Chaff', :price => 5 ).factions = all
Armament.create(:name => 'Flare', :price => 30 ).factions = all

Trooper.create(:name => 'Trooper', :price => 2 ).factions = all

Facility.create(:name => 'Industrial Complex', :price => 1200 ).factions = all
Facility.create(:name => 'Cargo Facility I', :price => 1600 ).factions = all
Facility.create(:name => 'Cargo Facility II', :price => 2400 ).factions = all
Facility.create(:name => 'Derilyn Platform', :price => 1800 ).factions = mand_merc
Facility.create(:name => 'Family Base', :price => 2000 ).factions = merc
Facility.create(:name => 'Factory', :price => 2400 ).factions = all
Facility.create(:name => 'Platforms', :price => 2400 ).factions = all
Facility.create(:name => 'Rebel Platform', :price => 3400 ).factions = reb
Facility.create(:name => 'Asteroid Hangar', :price => 3000 ).factions = mand_merc
Facility.create(:name => 'Golan I', :price => 2800 ).factions = all
Facility.create(:name => 'Golan II', :price => 4200 ).factions = all
Facility.create(:name => 'Golan III', :price => 5600 ).factions = all
Facility.create(:name => 'Imperial Research Center', :price => 4800 ).factions = imp
Facility.create(:name => 'Shipyard', :price => 6000 ).factions = all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
    
