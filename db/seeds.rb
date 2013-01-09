alderaan_asteroids = Planet.create(:name => 'Alderaan Asteroids', :credits => 500 )
bespin = Planet.create(:name => 'Bespin', :credits => 500 )
brr_clan_tradeport = Planet.create(:name => 'BrR Clan Tradeport', :credits => 500 )
cimf_station = Planet.create(:name => 'CIMF Station', :credits => 500 )
concord_dawn = Planet.create(:name => 'Concord Dawn', :credits => 500 )
corellia = Planet.create(:name => 'Corellia', :credits => 500 )
coruscant = Planet.create(:name => 'Coruscant', :credits => 500 )
dagobah = Planet.create(:name => 'Dagobah', :credits => 500 )
#dantooine = Planet.create(:name => 'Dantooine', :credits => 500 )
#deadalis_minefields = Planet.create(:name => 'Deadalis Minefields', :credits => 500 )
deathstar_III = Planet.create(:name => 'Death Star III', :credits => 500 )
endor = Planet.create(:name => 'Endor', :credits => 500 )
felucia = Planet.create(:name => 'Felucia', :credits => 500 )
geonosis = Planet.create(:name => 'Geonosis', :credits => 500 )
haruun_kal = Planet.create(:name => 'Haruun Kal', :credits => 500 )
hoth = Planet.create(:name => 'Hoth', :credits => 500 )
#hutt_space = Planet.create(:name => 'Hutts Minefields', :credits => 500 )
#ilum = Planet.create(:name => 'Ilum', :credits => 500 )
kamino = Planet.create(:name => 'Kamino', :credits => 500 )
kashyyyk = Planet.create(:name => 'Kashyyyk', :credits => 500 )
kessel_asteroids = Planet.create(:name => 'Kessel Asteroids', :credits => 500 )
kuat = Planet.create(:name => 'Kuat', :credits => 500 )
mandalore = Planet.create(:name => 'Mandalore', :credits => 500 )
mon_calamari = Planet.create(:name => 'Mon Calamari', :credits => 500 )
mustafar = Planet.create(:name => 'Mustafar', :credits => 500 )
mygeeto = Planet.create(:name => 'Mygeeto', :credits => 500 )
naboo = Planet.create(:name => 'Naboo', :credits => 500 )
nal_hutta = Planet.create(:name => 'Nal Hutta', :credits => 500 )
ord_ibanna = Planet.create(:name => 'Ord Ibanna', :credits => 500 )
#polis_massa = Planet.create(:name => 'Polis Massa', :credits => 500 )
rattatak = Planet.create(:name => 'Rattatak', :credits => 500 )
res_station = Planet.create(:name => 'RES Station', :credits => 500 )
rhen_var = Planet.create(:name => 'Rhen Var', :credits => 500 )
#silken_asteroids = Planet.create(:name => 'Silken Asteroids', :credits => 500 )
tatooine = Planet.create(:name => 'Tatooine', :credits => 500 )
utapau = Planet.create(:name => 'Utapau', :credits => 500 )
#vergesso_asteroids = Planet.create(:name => 'Vergesso Asteroids', :credits => 500 )
yavin = Planet.create(:name => 'Yavin', :credits => 500 )
#wormholeI = Planet.create(:name => 'Wormhole I', :credits => 0 )
#wormholeII = Planet.create(:name => 'Wormhole II', :credits => 0 )

Route.create(:vector_a => mygeeto, :vector_b => yavin, :distance => 1)
Route.create(:vector_a => mygeeto, :vector_b => alderaan_asteroids, :distance => 1)
Route.create(:vector_a => mygeeto, :vector_b => coruscant, :distance => 1)

Route.create(:vector_a => yavin, :vector_b => rhen_var, :distance => 1)
Route.create(:vector_a => yavin, :vector_b => alderaan_asteroids, :distance => 1)
Route.create(:vector_a => yavin, :vector_b => concord_dawn, :distance => 1)

Route.create(:vector_a => rhen_var, :vector_b => felucia, :distance => 1)
Route.create(:vector_a => rhen_var, :vector_b => concord_dawn, :distance => 1)

Route.create(:vector_a => deathstar_III, :vector_b => coruscant, :distance => 1)
Route.create(:vector_a => deathstar_III, :vector_b => bespin, :distance => 1)
Route.create(:vector_a => deathstar_III, :vector_b => rattatak, :distance => 1)

Route.create(:vector_a => coruscant, :vector_b => mandalore, :distance => 1)
Route.create(:vector_a => coruscant, :vector_b => alderaan_asteroids, :distance => 1)
Route.create(:vector_a => coruscant, :vector_b => bespin, :distance => 1)

Route.create(:vector_a => corellia, :vector_b => concord_dawn, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => kuat, :distance => 1)

Route.create(:vector_a => mandalore, :vector_b => corellia, :distance => 1)
Route.create(:vector_a => mandalore, :vector_b => alderaan_asteroids, :distance => 1)

Route.create(:vector_a => concord_dawn, :vector_b => felucia, :distance => 1)
Route.create(:vector_a => concord_dawn, :vector_b => kessel_asteroids, :distance => 1)
Route.create(:vector_a => concord_dawn, :vector_b => alderaan_asteroids, :distance => 1)

Route.create(:vector_a => felucia, :vector_b => mon_calamari, :distance => 1)
Route.create(:vector_a => felucia, :vector_b => kashyyyk, :distance => 1)
Route.create(:vector_a => felucia, :vector_b => kessel_asteroids, :distance => 1)

Route.create(:vector_a => mon_calamari, :vector_b => res_station, :distance => 1)
Route.create(:vector_a => mon_calamari, :vector_b => kashyyyk, :distance => 1)

Route.create(:vector_a => endor, :vector_b => bespin, :distance => 1)
Route.create(:vector_a => endor, :vector_b => hoth, :distance => 1)
Route.create(:vector_a => endor, :vector_b => cimf_station, :distance => 1)
Route.create(:vector_a => endor, :vector_b => rattatak, :distance => 1)
Route.create(:vector_a => endor, :vector_b => ord_ibanna, :distance => 1)

Route.create(:vector_a => bespin, :vector_b => rattatak, :distance => 1)
Route.create(:vector_a => bespin, :vector_b => mandalore, :distance => 1)
Route.create(:vector_a => bespin, :vector_b => hoth, :distance => 1)

Route.create(:vector_a => corellia, :vector_b => alderaan_asteroids, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => haruun_kal, :distance => 1)

Route.create(:vector_a => kuat, :vector_b => kessel_asteroids, :distance => 1)

Route.create(:vector_a => kessel_asteroids, :vector_b => kashyyyk, :distance => 1)
Route.create(:vector_a => kessel_asteroids, :vector_b => nal_hutta, :distance => 1)
Route.create(:vector_a => kessel_asteroids, :vector_b => corellia, :distance => 1)

Route.create(:vector_a => kashyyyk, :vector_b => res_station, :distance => 1)
Route.create(:vector_a => kashyyyk, :vector_b => kamino, :distance => 1)
Route.create(:vector_a => kashyyyk, :vector_b => nal_hutta, :distance => 1)

Route.create(:vector_a => cimf_station, :vector_b => rattatak, :distance => 1)
Route.create(:vector_a => cimf_station, :vector_b => mustafar, :distance => 1)

Route.create(:vector_a => hoth, :vector_b => haruun_kal, :distance => 1)
Route.create(:vector_a => hoth, :vector_b => ord_ibanna, :distance => 1)
Route.create(:vector_a => hoth, :vector_b => mandalore, :distance => 1)
Route.create(:vector_a => hoth, :vector_b => naboo, :distance => 1)

Route.create(:vector_a => haruun_kal, :vector_b => naboo, :distance => 1)
Route.create(:vector_a => haruun_kal, :vector_b => mandalore, :distance => 1)
Route.create(:vector_a => haruun_kal, :vector_b => geonosis, :distance => 1)
Route.create(:vector_a => haruun_kal, :vector_b => kuat, :distance => 1)

Route.create(:vector_a => kuat, :vector_b => nal_hutta, :distance => 1)
Route.create(:vector_a => kuat, :vector_b => tatooine, :distance => 1)
Route.create(:vector_a => kuat, :vector_b => geonosis, :distance => 1)

Route.create(:vector_a => nal_hutta, :vector_b => kamino, :distance => 1)
Route.create(:vector_a => nal_hutta, :vector_b => tatooine, :distance => 1)

Route.create(:vector_a => res_station, :vector_b => kamino, :distance => 1)

Route.create(:vector_a => mustafar, :vector_b => ord_ibanna, :distance => 1)
Route.create(:vector_a => mustafar, :vector_b => endor, :distance => 1)

Route.create(:vector_a => ord_ibanna, :vector_b => naboo, :distance => 1)
Route.create(:vector_a => ord_ibanna, :vector_b => dagobah, :distance => 1)

Route.create(:vector_a => naboo, :vector_b => geonosis, :distance => 1)
Route.create(:vector_a => naboo, :vector_b => utapau, :distance => 1)
Route.create(:vector_a => naboo, :vector_b => dagobah, :distance => 1)

Route.create(:vector_a => geonosis, :vector_b => tatooine, :distance => 1)
Route.create(:vector_a => geonosis, :vector_b => brr_clan_tradeport, :distance => 1)
Route.create(:vector_a => geonosis, :vector_b => utapau, :distance => 1)

Route.create(:vector_a => dagobah, :vector_b => utapau, :distance => 1)

Route.create(:vector_a => utapau, :vector_b => brr_clan_tradeport, :distance => 1)

Route.create(:vector_a => brr_clan_tradeport, :vector_b => tatooine, :distance => 1)

imp = ['empire']
reb = ['rebel']
imp_reb = ['empire','rebel']
merc = ['mercenary']
merc_reb = ['mercenary','rebel']
mand = ['mandalorian']
mand_merc = ['mandalorian','mercenary']
all = ['empire','rebel','mercenary','mandalorian']

Fighter.create(:name => 'Z-95', :price => 40 ).factions = merc_reb
Fighter.create(:name => 'T-Wing', :price => 40 ).factions = merc_reb
Fighter.create(:name => 'Y-Wing', :price => 70 ).factions = reb
Fighter.create(:name => 'X-Wing', :price => 80).factions = reb
Fighter.create(:name => 'A-Wing', :price => 110 ).factions = reb
Fighter.create(:name => 'B-Wing', :price => 145 ).factions = reb
Fighter.create(:name => 'Droid Fighter*', :hyperdrive => false, :price => 25 ).factions = merc
#Fighter.create(:name => 'Droid Tri-fighter*', :hyperdrive => false, :price => 35 ).factions = merc
Fighter.create(:name => 'Pinook Fighter', :price => 35 ).factions = merc
Fighter.create(:name => 'Preybird Fighter', :price => 50 ).factions = merc
Fighter.create(:name => 'Cloackshape Fighter', :price => 55 ).factions = merc
Fighter.create(:name => 'Planetary Fighter', :price => 55 ).factions = merc
Fighter.create(:name => 'R-41 Starchaser', :price => 65 ).factions = merc
Fighter.create(:name => 'Razor Fighter', :price => 70 ).factions = merc
Fighter.create(:name => 'Skipray Blastboat', :price => 105 ).factions = merc
Fighter.create(:name => 'V-Wing*', :hyperdrive => false, :price => 30 ).factions = mand
Fighter.create(:name => 'ARC-170', :price => 80 ).factions = mand
Fighter.create(:name => 'Pursuer', :price => 80 ).factions = mand
Fighter.create(:name => 'Firespray', :price => 95 ).factions = mand
Fighter.create(:name => 'Supa Fighter', :price => 70 ).factions = mand
Fighter.create(:name => 'Star Viper', :price => 95 ).factions = mand
Fighter.create(:name => 'Tie Fighter*', :hyperdrive => false, :price => 20 ).factions = imp
Fighter.create(:name => 'Tie Bomber*', :hyperdrive => false, :price => 25 ).factions = imp
Fighter.create(:name => 'Tie Interceptor*', :hyperdrive => false, :price => 30 ).factions = imp
Fighter.create(:name => 'Authority IRD*', :hyperdrive => false, :price => 45 ).factions = imp
Fighter.create(:name => 'Toscan Fighter', :price => 90 ).factions = imp
Fighter.create(:name => 'Tie Avenger', :price => 110 ).factions = imp
Fighter.create(:name => 'Assault Gunboat', :price => 120 ).factions = imp
Fighter.create(:name => 'Tie Phantom', :price => 145 ).factions = imp
Fighter.create(:name => 'Missile Boat', :price => 225 ).factions = imp
Fighter.create(:name => 'Tie Defender', :price => 320 ).factions = imp

LightTransport.create(:name => 'YT-1300', :price => 110 ).factions = merc
LightTransport.create(:name => 'YT-2000', :price => 320 ).factions = merc
LightTransport.create(:name => 'YT-2400', :price => 145 ).factions = mand
LightTransport.create(:name => 'Millenium Falcon', :price => 270 ).factions = merc_reb

LightTransport.create(:name => 'Assault Transport', :price => 200 ).factions = all
LightTransport.create(:name => 'Escort Transport', :price => 200 ).factions = all
LightTransport.create(:name => 'Stormtrooper Transport', :price => 55 ).factions = all
LightTransport.create(:name => 'Assault Shuttle', :price => 175 ).factions = imp
LightTransport.create(:name => 'System Patrol Craft', :price => 280 ).factions = imp

LightTransport.create(:name => 'Bulk Freighter', :price => 75 ).factions = all
LightTransport.create(:name => 'Mod Action Transport', :price => 100 ).factions = all
LightTransport.create(:name => 'Modular Conveyor', :price => 100 ).factions = all
LightTransport.create(:name => 'Suprosa', :price => 450 ).factions = all

CapitalShip.create(:name => 'Corellian Gunship', :price => 320 ).factions = all
CapitalShip.create(:name => 'Corellian Corvette', :price => 320 ).factions = all
CapitalShip.create(:name => 'Mod Corvette', :price => 350 ).factions = all
CapitalShip.create(:name => 'Nebulon B Frigate', :price => 400 ).factions = all
CapitalShip.create(:name => 'Nebulon B2 Frigate', :price => 560 ).factions = all
CapitalShip.create(:name => 'Carrack Cruiser', :price => 400 ).factions = imp
CapitalShip.create(:name => 'Lancer Frigate', :price => 450 ).factions = imp
CapitalShip.create(:name => 'Marauder Corvette', :price => 650 ).factions = mand_merc
CapitalShip.create(:name => 'Dreadnaught', :price => 1000 ).factions = all
CapitalShip.create(:name => 'Escort Carrier', :price => 720 ).factions = imp
CapitalShip.create(:name => 'Lt Calamari Cruiser', :price => 750 ).factions = reb
CapitalShip.create(:name => 'Bulk Cruiser', :price => 800 ).factions = merc
CapitalShip.create(:name => 'Strike Cruiser', :price => 1150 ).factions = imp_reb
CapitalShip.create(:name => 'Assault Frigate', :price => 1350 ).factions = reb
CapitalShip.create(:name => 'Munificent Frigate', :price => 1450 ).factions = merc
CapitalShip.create(:name => 'Acclamator Assault Ship', :price => 1450 ).factions = mand
CapitalShip.create(:name => 'Victory Star Destroyer', :price => 1500 ).factions = imp
CapitalShip.create(:name => 'Venator Star Destroyer', :price => 1600 ).factions = mand
CapitalShip.create(:name => 'Providence Destroyer', :price => 1600 ).factions = merc
CapitalShip.create(:name => 'Reef Home Calamari Cruiser', :price => 1600 ).factions = reb
CapitalShip.create(:name => 'Liberty Calamari Cruiser', :price => 1600 ).factions = reb
CapitalShip.create(:name => 'Victory Star Destroyer II', :price => 1700 ).factions = imp
CapitalShip.create(:name => 'Liberator Cruiser', :price => 1750 ).factions = reb
CapitalShip.create(:name => 'Interdictor', :price => 2500 ).factions = imp
CapitalShip.create(:name => 'Dauntless Cruiser', :price => 1950 ).factions = reb
CapitalShip.create(:name => 'Imperial Star Destroyer', :price => 2000 ).factions = imp
CapitalShip.create(:name => 'Dominator Interdictor', :price => 2800 ).factions = imp
CapitalShip.create(:name => 'Imperial Star Destroyer II', :price => 2250 ).factions = imp
CapitalShip.create(:name => 'Lucrehulk Battleship', :price => 4400 ).factions = mand_merc
CapitalShip.create(:name => 'Bulkwark Cruiser', :price => 5750 ).factions = reb
CapitalShip.create(:name => 'Super Star Destroyer', :price => 6700 ).factions = imp

Armament.create(:name => 'Concussion Missile', :price => 10 ).factions = all
Armament.create(:name => 'Proton Torpedo', :price => 10 ).factions = all
Armament.create(:name => 'Ion Pulse Torpedo', :price => 15 ).factions = reb
Armament.create(:name => 'Adv Missile', :price => 20 ).factions = all
Armament.create(:name => 'Adv Torpedo', :price => 25 ).factions = all
Armament.create(:name => 'Mag Pulse Torpedo', :price => 30 ).factions = all
Armament.create(:name => 'Heavy Rocket', :price => 50 ).factions = all
Armament.create(:name => 'Space Bomb', :price => 70 ).factions = all

Armament.create(:name => 'Chaff', :price => 2 ).factions = all
Armament.create(:name => 'Flare', :price => 20 ).factions = all

Trooper.create(:name => 'Trooper', :price => 1 ).factions = all

Facility.create(:name => 'Industrial Complex', :price => 1200 ).factions = all
Facility.create(:name => 'Cargo Facility I', :price => 1500 ).factions = all
Facility.create(:name => 'Cargo Facility II', :price => 2400 ).factions = all
Facility.create(:name => 'Derilyn Platform', :price => 1800 ).factions = mand_merc
Facility.create(:name => 'Family Base', :price => 2100 ).factions = merc
Facility.create(:name => 'Factory', :price => 2400 ).factions = all
Facility.create(:name => 'Platforms', :price => 2400 ).factions = all
Facility.create(:name => 'Rebel Platform', :price => 3450 ).factions = reb
Facility.create(:name => 'Asteroid Hangar', :price => 3000 ).factions = mand_merc
Facility.create(:name => 'Golan I', :price => 3000 ).factions = all
Facility.create(:name => 'Golan II', :price => 3900 ).factions = all
Facility.create(:name => 'Golan III', :price => 6000 ).factions = all
Facility.create(:name => 'Imperial Research Center', :price => 4200 ).factions = imp
Facility.create(:name => 'Shipyard', :price => 4500 ).factions = all

Warrior.create(:name => 'Jango Fett', :price => 50 ).factions = mand
Warrior.create(:name => 'Boba Fett', :price => 40 ).factions = mand
Warrior.create(:name => 'Kyle Katarn', :price => 40 ).factions = reb
Warrior.create(:name => 'Luke Skywalker', :price => 50 ).factions = reb
Warrior.create(:name => 'Han Solo', :price => 50 ).factions = merc
Warrior.create(:name => 'Chewbacca', :price => 40 ).factions = merc
Warrior.create(:name => 'Darth Vader', :price => 40 ).factions = imp
Warrior.create(:name => 'Emperor Palpatine', :price => 50 ).factions = imp

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
    
