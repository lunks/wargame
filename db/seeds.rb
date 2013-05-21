#alderaan_asteroids = Planet.create(:name => 'Alderaan Asteroids', :credits => 400 )
bespin = Planet.create(:name => 'Bespin', :credits => 400, :description => 'Bespin:Platform' )
brr_station = Planet.create(:name => 'BrR Station', :credits => 0, :tradeport => true, :description => 'Zona Neutra' )
cimf_station = Planet.create(:name => 'CIMF Station', :credits => 0, :tradeport => true, :description => 'Zona Neutra' )
concord_dawn = Planet.create(:name => 'Concord Dawn', :credits => 400, :description => 'Concord Dawn' )
corellia = Planet.create(:name => 'Corellia', :credits => 400, :description => 'Naboo Plains' )
coruscant = Planet.create(:name => 'Coruscant', :credits => 400, :description => 'Coruscant' )
dagobah = Planet.create(:name => 'Dagobah', :credits => 400, :description => 'Dagobah' )
#dantooine = Planet.create(:name => 'Dantooine', :credits => 400 )
#deadalis_minefields = Planet.create(:name => 'Deadalis Minefields', :credits => 400 )
deathstar = Planet.create(:name => 'Death Star', :credits => 400, :description => 'Deathstar' )
endor = Planet.create(:name => 'Endor', :credits => 400, :description => 'Endor / Kashyyyk' )
felucia = Planet.create(:name => 'Felucia', :credits => 400, :description => 'Felucia' )
geonosis = Planet.create(:name => 'Geonosis', :credits => 400, :description => 'Geonosis / Concord Dawn' )
haruun_kal = Planet.create(:name => 'Haruun Kal', :credits => 400, :description => 'Haruun Kal' )
hoth = Planet.create(:name => 'Hoth', :credits => 400, :description => 'Hoth / RhenVar Harbor' )
#hutt_space = Planet.create(:name => 'Hutts Minefields', :credits => 400 )
#ilum = Planet.create(:name => 'Ilum', :credits => 400 )
kamino = Planet.create(:name => 'Kamino', :credits => 400, :description => 'Kamino' )
kashyyyk = Planet.create(:name => 'Kashyyyk', :credits => 400, :description => 'Kashyyyk' )
kessel_asteroids = Planet.create(:name => 'Kessel Asteroids', :credits => 400, :description => 'Polis Massa' )
kuat = Planet.create(:name => 'Kuat', :credits => 400, :description => 'Ord Ibanna' )
mandalore = Planet.create(:name => 'Mandalore', :credits => 400, :description => 'Yavin Arena' )
mon_calamari = Planet.create(:name => 'Mon Calamari', :credits => 400, :description => 'Kamino Tipoca City' )
mustafar = Planet.create(:name => 'Mustafar', :credits => 400, :description => 'Mustafar' )
mygeeto = Planet.create(:name => 'Mygeeto', :credits => 400, :description => 'Mygeeto' )
naboo = Planet.create(:name => 'Naboo', :credits => 400, :description => 'Naboo' )
nal_hutta = Planet.create(:name => 'Nal Hutta', :credits => 400, :description => 'Jabba Palace' )
ord_ibanna = Planet.create(:name => 'Ord Ibanna', :credits => 400, :description => 'Ord Ibanna' )
polis_massa = Planet.create(:name => 'Polis Massa', :credits => 400, :description => 'Polis Massa' )
rattatak = Planet.create(:name => 'Rattatak', :credits => 400, :description => 'Rattatak' )
res_station = Planet.create(:name => 'RES Station', :credits => 0, :tradeport => true, :description => 'Zona Neutra' )
rhen_var = Planet.create(:name => 'Rhen Var', :credits => 400, :description => 'Rhen Var Citadel' )
#silken_asteroids = Planet.create(:name => 'Silken Asteroids', :credits => 400 )
tatooine = Planet.create(:name => 'Tatooine', :credits => 400, :description => 'Mos Eisley' )
utapau = Planet.create(:name => 'Utapau', :credits => 400, :description => 'Utapau' )
#vergesso_asteroids = Planet.create(:name => 'Vergesso Asteroids', :credits => 400 )
yavin = Planet.create(:name => 'Yavin', :credits => 400, :description => 'Yavin 4' )
#wormholeI = Planet.create(:name => 'Wormhole I', :credits => 0 )
#wormholeII = Planet.create(:name => 'Wormhole II', :credits => 0 )

Route.create(:vector_a => mygeeto, :vector_b => yavin, :distance => 1)
Route.create(:vector_a => mygeeto, :vector_b => deathstar, :distance => 1)
Route.create(:vector_a => mygeeto, :vector_b => coruscant, :distance => 1)

Route.create(:vector_a => yavin, :vector_b => rhen_var, :distance => 1)
Route.create(:vector_a => yavin, :vector_b => deathstar, :distance => 1)
Route.create(:vector_a => yavin, :vector_b => concord_dawn, :distance => 1)

Route.create(:vector_a => rhen_var, :vector_b => felucia, :distance => 1)
Route.create(:vector_a => rhen_var, :vector_b => concord_dawn, :distance => 1)

Route.create(:vector_a => deathstar, :vector_b => coruscant, :distance => 1)

Route.create(:vector_a => coruscant, :vector_b => mandalore, :distance => 1)

Route.create(:vector_a => coruscant, :vector_b => bespin, :distance => 1)

Route.create(:vector_a => corellia, :vector_b => concord_dawn, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => kuat, :distance => 1)

Route.create(:vector_a => mandalore, :vector_b => corellia, :distance => 1)
Route.create(:vector_a => mandalore, :vector_b => deathstar, :distance => 1)

Route.create(:vector_a => concord_dawn, :vector_b => felucia, :distance => 1)
Route.create(:vector_a => concord_dawn, :vector_b => kessel_asteroids, :distance => 1)
Route.create(:vector_a => concord_dawn, :vector_b => deathstar, :distance => 1)

Route.create(:vector_a => felucia, :vector_b => mon_calamari, :distance => 1)
Route.create(:vector_a => felucia, :vector_b => kashyyyk, :distance => 1)
Route.create(:vector_a => felucia, :vector_b => kessel_asteroids, :distance => 1)

Route.create(:vector_a => mon_calamari, :vector_b => res_station, :distance => 1)
Route.create(:vector_a => mon_calamari, :vector_b => kashyyyk, :distance => 1)

Route.create(:vector_a => endor, :vector_b => bespin, :distance => 1)
Route.create(:vector_a => endor, :vector_b => hoth, :distance => 1)

Route.create(:vector_a => endor, :vector_b => rattatak, :distance => 1)
Route.create(:vector_a => endor, :vector_b => ord_ibanna, :distance => 1)
Route.create(:vector_a => endor, :vector_b => polis_massa, :distance => 1)

Route.create(:vector_a => bespin, :vector_b => rattatak, :distance => 1)
Route.create(:vector_a => bespin, :vector_b => mandalore, :distance => 1)
Route.create(:vector_a => bespin, :vector_b => hoth, :distance => 1)

Route.create(:vector_a => corellia, :vector_b => deathstar, :distance => 1)
Route.create(:vector_a => corellia, :vector_b => haruun_kal, :distance => 1)

Route.create(:vector_a => kuat, :vector_b => kessel_asteroids, :distance => 1)

Route.create(:vector_a => kessel_asteroids, :vector_b => kashyyyk, :distance => 1)
Route.create(:vector_a => kessel_asteroids, :vector_b => nal_hutta, :distance => 1)
Route.create(:vector_a => kessel_asteroids, :vector_b => corellia, :distance => 1)

Route.create(:vector_a => kashyyyk, :vector_b => res_station, :distance => 1)
Route.create(:vector_a => kashyyyk, :vector_b => kamino, :distance => 1)
Route.create(:vector_a => kashyyyk, :vector_b => nal_hutta, :distance => 1)

Route.create(:vector_a => cimf_station, :vector_b => rattatak, :distance => 1)
Route.create(:vector_a => cimf_station, :vector_b => coruscant, :distance => 1)
Route.create(:vector_a => cimf_station, :vector_b => bespin, :distance => 1)

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

Route.create(:vector_a => mustafar, :vector_b => endor, :distance => 1)
Route.create(:vector_a => mustafar, :vector_b => rattatak, :distance => 1)
Route.create(:vector_a => mustafar, :vector_b => polis_massa, :distance => 1)

Route.create(:vector_a => ord_ibanna, :vector_b => naboo, :distance => 1)
Route.create(:vector_a => ord_ibanna, :vector_b => dagobah, :distance => 1)
Route.create(:vector_a => ord_ibanna, :vector_b => polis_massa, :distance => 1)

Route.create(:vector_a => naboo, :vector_b => geonosis, :distance => 1)
Route.create(:vector_a => naboo, :vector_b => utapau, :distance => 1)
Route.create(:vector_a => naboo, :vector_b => dagobah, :distance => 1)

Route.create(:vector_a => geonosis, :vector_b => tatooine, :distance => 1)
Route.create(:vector_a => geonosis, :vector_b => brr_station, :distance => 1)
Route.create(:vector_a => geonosis, :vector_b => utapau, :distance => 1)

Route.create(:vector_a => dagobah, :vector_b => utapau, :distance => 1)

Route.create(:vector_a => utapau, :vector_b => brr_station, :distance => 1)

Route.create(:vector_a => brr_station, :vector_b => tatooine, :distance => 1)

imp = ['empire']
reb = ['rebel']
imp_reb = ['empire','rebel']
merc = ['mercenary']
merc_reb = ['mercenary','rebel']
mand = ['mandalorian']
mand_merc = ['mandalorian','mercenary']
all = ['empire','rebel','mercenary','mandalorian']

Facility.create(:name => 'Ind.Complex', :price => 1200, :description => 'Comboio(3 Bulk Freighter, 2 Cargo Ferry)' ).factions = all
Facility.create(:name => 'Pirate S.Yard', :price => 1200, :description => 'Comboio(3 Bulk Freighter, 2 Xyitiar Transp)' ).factions = all
Facility.create(:name => 'Cargo Fac.I', :price => 1500, :description => 'Comboio(3 Bulk Freighter, 2 Cargo Ferry)').factions = all
Facility.create(:name => 'Cargo Fac.II', :price => 2400, :description => 'Comboio(3 Bulk Freighter, Mod.Conveyor)' ).factions = all
Facility.create(:name => 'Derilyn Plat', :price => 1800, :description => 'Comboio(3 Bulk Freighter, 2 Xyitiar Transp' ).factions = mand_merc
Facility.create(:name => 'Family Base', :price => 2100, :description => 'Comboio(3 Bulk Freighter, 2 Xyitiar Transp)' ).factions = merc
Facility.create(:name => 'Factory', :price => 2400, :description => 'Comboio(4 Bulk Freighter, 2 Mod.Action)' ).factions = all
Facility.create(:name => 'Platforms', :price => 2400, :description => 'Comboio(4 Bulk Freighter, 2 Mod. Action)' ).factions = all
Facility.create(:name => 'Rebel Plat', :price => 3450, :description => 'Comboio(4 Bulk Freighter, 2 Reb Med Transp)' ).factions = reb
Facility.create(:name => 'Ast. Hangar', :price => 3000, :description => 'Comboio(4 Bulk Freighter, 2 Xyitiar Transp)' ).factions = mand_merc
Facility.create(:name => 'Golan I', :price => 3000, :description => 'Comboio(4 Bulk Freighter, 2 Mod Action)' ).factions = all
Facility.create(:name => 'Golan II', :price => 3900, :description => 'Comboio(4 Bulk Freighter, 2 Container Transp)' ).factions = all
Facility.create(:name => 'Golan III', :price => 6000, :description => 'Comboio(4 Bulk Freighter, 1 Suprosa)' ).factions = all
Facility.create(:name => 'Imp Res Center', :price => 4200, :description => 'Comboio(4 Bulk Freighter, 1 Star Galleon)' ).factions = imp
Facility.create(:name => 'Shipyard', :price => 4500, :description => 'Comboio(4 Bulk Freighter, 1 Suprosa)' ).factions = all

Sensor.create(:name => 'Comm Relay', :price => 1000, :description => 'So pode ser movida com Capital Ship ou Transporte' ).factions = all
Sensor.create(:name => 'Sensor Array', :price => 1000, :description => 'So pode ser movida com Capital Ship ou Transporte' ).factions = all

Fighter.create(:name => 'Z-95', :price => 40 ).factions = merc_reb
Fighter.create(:name => 'T-Wing', :price => 40 ).factions = merc_reb
Fighter.create(:name => 'Y-Wing', :price => 70 ).factions = reb
Fighter.create(:name => 'X-Wing', :price => 80 ).factions = reb
Fighter.create(:name => 'A-Wing', :price => 110 ).factions = reb
Fighter.create(:name => 'B-Wing', :price => 145 ).factions = reb
Fighter.create(:name => 'Droid Fighter*', :hyperdrive => false, :price => 25 ).factions = merc
#Fighter.create(:name => 'Droid Tri-fighter*', :hyperdrive => false, :price => 35 ).factions = merc
Fighter.create(:name => 'Pinook Fighter', :price => 35 ).factions = merc
Fighter.create(:name => 'Preybird Fighter', :price => 50 ).factions = merc
Fighter.create(:name => 'Clockshape Fighter', :price => 55 ).factions = merc
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

CapitalShip.create(:name => 'Corellian Gunship', :price => 320, :description => 'Permite +1 nave simultanea no XWA' ).factions = all
CapitalShip.create(:name => 'Corellian Corvette', :price => 320, :description => 'Permite +1 nave simultanea no XWA' ).factions = all
CapitalShip.create(:name => 'Mod Corvette', :price => 350, :description => 'Permite +1 nave simultanea no XWA' ).factions = all
CapitalShip.create(:name => 'Nebulon B Frigate', :price => 400, :description => 'Permite +1 nave simultanea no XWA' ).factions = all
CapitalShip.create(:name => 'Mod Nebulon Frigate', :price => 560, :description => 'Permite +1 nave simultanea no XWA' ).factions = all
CapitalShip.create(:name => 'Carrack Cruiser', :price => 400, :description => 'Permite +1 nave simultanea no XWA' ).factions = imp
CapitalShip.create(:name => 'Lancer Frigate', :price => 450, :description => 'Permite +1 nave simultanea no XWA' ).factions = imp
CapitalShip.create(:name => 'Marauder Corvette', :price => 650, :description => 'Permite +1 nave simultanea no XWA' ).factions = mand_merc
CapitalShip.create(:name => 'Dreadnaught', :price => 1000, :description => 'Permite +2 naves simultaneas no XWA' ).factions = all
CapitalShip.create(:name => 'Escort Carrier', :price => 720, :description => 'Permite +2 naves simultaneas no XWA' ).factions = imp
CapitalShip.create(:name => 'Lt Calamari Cruiser', :price => 750, :description => 'Permite +2 naves simultaneas no XWA' ).factions = reb
CapitalShip.create(:name => 'Bulk Cruiser', :price => 800, :description => 'Permite +2 naves simultaneas no XWA' ).factions = merc
CapitalShip.create(:name => 'Strike Cruiser', :price => 1150, :description => 'Permite +2 naves simultaneas no XWA' ).factions = imp_reb
CapitalShip.create(:name => 'Assault Frigate', :price => 1350, :description => 'Permite +2 naves simultaneas no XWA' ).factions = reb
CapitalShip.create(:name => 'Munificent Frigate', :price => 1450, :description => 'Permite +3 naves simultaneas no XWA' ).factions = merc
CapitalShip.create(:name => 'Acclamator Ass Ship', :price => 1450, :description => 'Permite +3 naves simultaneas no XWA' ).factions = mand
CapitalShip.create(:name => 'Victory SD', :price => 1500, :description => 'Permite +3 naves simultaneas no XWA' ).factions = imp
CapitalShip.create(:name => 'Venator SD', :price => 1600, :description => 'Permite +3 naves simultaneas no XWA' ).factions = mand
CapitalShip.create(:name => 'Providence Destroyer', :price => 1600, :description => 'Permite +3 naves simultaneas no XWA' ).factions = merc
CapitalShip.create(:name => 'ReefHome Cal.Cruiser', :price => 1600, :description => 'Permite +3 naves simultaneas no XWA' ).factions = reb
CapitalShip.create(:name => 'Liberty Cal.Cruiser', :price => 1600, :description => 'Permite +3 naves simultaneas no XWA' ).factions = reb
CapitalShip.create(:name => 'Victory SD II', :price => 1700, :description => 'Permite +3 naves simultaneas no XWA' ).factions = imp
CapitalShip.create(:name => 'Liberator Cruiser', :price => 1750, :description => 'Permite +3 naves simultaneas no XWA' ).factions = reb
CapitalShip.create(:name => 'Interdictor', :price => 2500, :description => 'Permite +3 naves simultaneas no XWA' ).factions = imp
CapitalShip.create(:name => 'Dauntless Cruiser', :price => 1950, :description => 'Permite +3 naves simultaneas no XWA' ).factions = reb
CapitalShip.create(:name => 'Imperial SD', :price => 2000, :description => 'Permite +3 naves simultaneas no XWA' ).factions = imp
CapitalShip.create(:name => 'Dom Interdictor', :price => 2800, :description => 'Permite +3 naves simultaneas no XWA' ).factions = imp
CapitalShip.create(:name => 'Imperial SD II', :price => 2250, :description => 'Permite +3 naves simultaneas no XWA' ).factions = imp
CapitalShip.create(:name => 'Lucrehulk Battleship', :price => 4400, :description => 'Permite +4 naves simultaneas no XWA' ).factions = mand_merc
CapitalShip.create(:name => 'Bulkwark Cruiser', :price => 5750, :description => 'Permite +4 naves simultaneas no XWA' ).factions = reb
CapitalShip.create(:name => 'Super Star Destroyer', :price => 6700, :description => 'Permite +4 naves simultaneas no XWA' ).factions = imp

LightTransport.create(:name => 'YT-1300', :price => 110 ).factions = merc
LightTransport.create(:name => 'YT-2000', :price => 320 ).factions = merc
LightTransport.create(:name => 'YT-2400', :price => 145 ).factions = mand
LightTransport.create(:name => 'Millenium Falcon', :price => 270 ).factions = merc_reb

LightTransport.create(:name => 'Assault Transport', :price => 200 ).factions = all
LightTransport.create(:name => 'Escort Transport', :price => 200 ).factions = all
LightTransport.create(:name => 'Stormtrooper Trans.', :price => 55 ).factions = all
LightTransport.create(:name => 'Assault Shuttle', :price => 175 ).factions = imp
LightTransport.create(:name => 'System Pat Craft', :price => 250 ).factions = imp

LightTransport.create(:name => 'Cargo Ferry', :price => 60 ).factions = all
LightTransport.create(:name => 'Container Transp', :price => 60 ).factions = all
LightTransport.create(:name => 'Mod Action Transp', :price => 60 ).factions = all
LightTransport.create(:name => 'Modular Conveyor', :price => 60 ).factions = all
LightTransport.create(:name => 'Xyitiar Transp', :price => 60 ).factions = merc
LightTransport.create(:name => 'Star Galleon', :price => 100 ).factions = imp
LightTransport.create(:name => 'Suprosa', :price => 200 ).factions = all

Armament.create(:name => 'Missile', :price => 5 ).factions = all
Armament.create(:name => 'Proton Torpedo', :price => 5 ).factions = all
Armament.create(:name => 'Ion Pulse Torp', :price => 5 ).factions = reb
Armament.create(:name => 'Adv Missile', :price => 10 ).factions = all
Armament.create(:name => 'Adv Torpedo', :price => 10 ).factions = all
Armament.create(:name => 'Mag Pulse Torp', :price => 15 ).factions = all
Armament.create(:name => 'Heavy Rocket', :price => 15 ).factions = all
Armament.create(:name => 'Space Bomb', :price => 20 ).factions = all
Armament.create(:name => 'Chaff', :price => 1 ).factions = all
Armament.create(:name => 'Flare', :price => 15 ).factions = all

Trooper.create(:name => 'Trooper', :price => 1 ).factions = all

Commander.create(:name => 'Almirante Ackbar', :price => 1000, :description => 'Permite AI Super Ace + CS misseis no XWA'  ).factions = reb
Commander.create(:name => 'Capitao Dodonna', :price => 800, :description => 'Permite AI Top Ace no XWA'  ).factions = reb
Commander.create(:name => 'Almirante Piett', :price => 1000, :description => 'Permite AI Super Ace + CS misseis no XWA' ).factions = imp
Commander.create(:name => 'Capitao Needa', :price => 800, :description => 'Permite AI Top Ace no XWA' ).factions = imp
Commander.create(:name => 'Almirante Trench', :price => 1000, :description => 'Permite AI Super Ace + CS misseis no XWA' ).factions = merc
Commander.create(:name => 'Capitao Canteval', :price => 800, :description => 'Permite AI Top Ace no XWA' ).factions = merc
Commander.create(:name => 'Almirante Wieler', :price => 1000, :description => 'Permite AI Super Ace + CS misseis no XWA' ).factions = mand
Commander.create(:name => 'Capitao Autem', :price => 800, :description => 'Permite AI Top Ace no XWA' ).factions = mand

Warrior.create(:name => 'Jango Fett', :price => 50, :description => 'Dark Jedi' ).factions = mand
Warrior.create(:name => 'Boba Fett', :price => 40, :description => 'Dark Jedi' ).factions = mand
Warrior.create(:name => 'Kyle Katarn', :price => 40, :description => 'Jedi' ).factions = reb
Warrior.create(:name => 'Luke Skywalker', :price => 50, :description => 'Jedi' ).factions = reb
Warrior.create(:name => 'Han Solo', :price => 50, :description => 'Dark Jedi' ).factions = merc
Warrior.create(:name => 'Chewbacca', :price => 40, :description => 'Dark Jedi' ).factions = merc
Warrior.create(:name => 'Darth Vader', :price => 40, :description => 'Sith' ).factions = imp
Warrior.create(:name => 'Emperor Palpatine', :price => 50, :description => 'Sith' ).factions = imp

Goal.create(:description => 'Destruir o esquadrao vermelho. Se voce for o vermelho ou outro jogador destrui-lo, a missao passa a ser dominar 10 planetas')
Goal.create(:description => 'Destruir o esquadrao amarelo. Se você for o amarelo ou outro jogador destrui-lo, a missao passa a ser dominar 10 planetas')
Goal.create(:description => 'Destruir o esquadrao verde. Se você for o verde ou outro jogador destrui-lo, a missao passa a ser dominar 10 planetas')
Goal.create(:description => 'Dominar Coruscant, Mustafar, Geonosis e Kamino')
Goal.create(:description => 'Dominar Hoth, DeathStar, Kashyyyk, Utapau')
Goal.create(:description => 'Dominar na totalidade o setor Norte e Kamino')
Goal.create(:description => 'Dominar na totalidade o setor Leste e Naboo')
Goal.create(:description => 'Dominar na totalidade o setor Sul e Mustafar (inverter com Polis Massa)')
Goal.create(:description => 'Dominar na totalidade o setor Oeste e Yavin')



# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
    
