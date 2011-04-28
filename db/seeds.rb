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

Fighter.create(:name => '(X-W) X-Wing', :price => 250).factions = reb
Fighter.create(:name => '(Y-W) Y-Wing', :price => 250 ).factions = reb
Fighter.create(:name => '(A-W) A-Wing', :price => 350 ).factions = reb
Fighter.create(:name => '(B-W) B-Wing', :price => 475 ).factions = reb
Fighter.create(:name => '(T-W) T-Wing', :price => 130 ).factions = merc_reb
Fighter.create(:name => '(Z-95) Z-95', :price => 130 ).factions = merc_reb
Fighter.create(:name => 'Droid Fighter', :hyperdrive => false, :price => 90 ).factions = merc
Fighter.create(:name => 'Droid Tri-fighter', :hyperdrive => false, :price => 80 ).factions = merc
Fighter.create(:name => '(PNK/F) Pinook Fighter', :price => 120 ).factions = merc
Fighter.create(:name => '(PRY/F) Preybird Fighter', :price => 150 ).factions = merc
Fighter.create(:name => '(R-41) R-41 Starchaser', :price => 200 ).factions = merc
Fighter.create(:name => '(CLK/F) Cloackshape Fighter', :price => 200 ).factions = merc
Fighter.create(:name => '(PLT/F) Planetary Fighter', :price => 200 ).factions = merc
Fighter.create(:name => '(RZR/F) Razor Fighter', :price => 225 ).factions = merc
Fighter.create(:name => '(IG2000) IG-2000', :price => 550 ).factions = merc
Fighter.create(:name => '(S/B) Skipray Blastboat', :price => 350 ).factions = merc
Fighter.create(:name => '(SUP/F) Supa Fighter', :price => 250 ).factions = mand
Fighter.create(:name => '(FRS) Firespray', :price => 300 ).factions = mand
Fighter.create(:name => '(PES) Pursuer', :price => 275 ).factions = mand
Fighter.create(:name => '(S/V) Star Viper', :price => 300 ).factions = mand
Fighter.create(:name => '(V-W) V-Wing', :hyperdrive => false, :price => 150 ).factions = mand
Fighter.create(:name => '(ARC) ARC-170', :price => 250 ).factions = mand
Fighter.create(:name => '(T/F) Tie Fighter', :hyperdrive => false, :price => 60 ).factions = imp
Fighter.create(:name => '(T/B) Tie Bomber', :hyperdrive => false, :price => 70 ).factions = imp
Fighter.create(:name => '(T/I) Tie Interceptor', :hyperdrive => false, :price => 90 ).factions = imp
Fighter.create(:name => '(T/A) Tie Avenger', :price => 400 ).factions = imp
Fighter.create(:name => '(IRD) Authority IRD', :hyperdrive => false, :price => 115 ).factions = imp
Fighter.create(:name => '(TOS) Toscan Fighter', :price => 300 ).factions = imp
Fighter.create(:name => '(T/Ax1) Tie Advanced X1', :price => 400 ).factions = imp
Fighter.create(:name => '(GUN) Assault Gunboat', :price => 450 ).factions = imp
Fighter.create(:name => '(M/B) Missile Boat', :price => 500 ).factions = imp
Fighter.create(:name => '(T/P) Tie Phantom', :price => 500 ).factions = imp
Fighter.create(:name => '(T/D) Tie Defender', :price => 1000 ).factions = imp

LightTransport.create(:name => '(CORT) YT-1300', :price => 600 ).factions = merc
LightTransport.create(:name => '(OTANA) YT-2000', :price => 1800 ).factions = merc
LightTransport.create(:name => '(OUT) YT-2400', :price => 800 ).factions = mand
LightTransport.create(:name => '(FALCON) Millenium Falcon', :price => 1500 ).factions = merc_reb

LightTransport.create(:name => '(ATR) Assault Transport', :price => 1300 ).factions = all
LightTransport.create(:name => '(ETR) Escort Transport', :price => 1300 ).factions = all
LightTransport.create(:name => '(E/S) Escort Shuttle', :price => 580 ).factions = all
LightTransport.create(:name => '(SCT) Scout Craft', :price => 820 ).factions = all
LightTransport.create(:name => '(SHU) Shuttle', :price => 400 ).factions = all
LightTransport.create(:name => '(TRN) Stormtrooper Transport', :price => 400 ).factions = all
LightTransport.create(:name => '(SPC) System Patrol Craft', :price => 1800 ).factions = imp
LightTransport.create(:name => '(A/S) Assault Shuttle', :price => 1100 ).factions = imp

CapitalShip.create(:name => '(A/ESC) Alliance Escort Carrier', :price => 1400 ).factions = reb
CapitalShip.create(:name => '(R/CRS) Reef Home Calamari Cruiser', :price => 5500 ).factions = reb
CapitalShip.create(:name => '(CLR) Lt Calamari Cruiser', :price => 2200 ).factions = reb
CapitalShip.create(:name => '(L/CRS) Liberty Calamari Cruiser', :price => 5500 ).factions = reb
CapitalShip.create(:name => '(A/FRG) Assault Frigate', :price => 4300 ).factions = reb
CapitalShip.create(:name => 'Liberator Cruiser', :price => 6200 ).factions = reb
CapitalShip.create(:name => '(DAUNT) Dauntless Cruiser', :price => 7200 ).factions = reb
CapitalShip.create(:name => '(BULKII) Bulkwark Cruiser', :price => 30000 ).factions = reb
CapitalShip.create(:name => '(M/CRV) Mod Corvette', :price => 1000 ).factions = merc
CapitalShip.create(:name => '(M-CRV) Marauder Corvette', :price => 2100 ).factions = merc
CapitalShip.create(:name => '(PCD) Providence Destroyer', :price => 5600 ).factions = merc
CapitalShip.create(:name => 'Munificent Frigate', :price => 5200 ).factions = merc
CapitalShip.create(:name => '(DREAD) Dreadnaught', :price => 3200 ).factions = all
CapitalShip.create(:name => '(B/CRS) Bulk Cruiser', :price => 2600 ).factions = merc
CapitalShip.create(:name => '(L/FRG) Lancer Frigate', :price => 1400 ).factions = imp
CapitalShip.create(:name => '(GSP) Corellian Gunship', :price => 1100 ).factions = all
CapitalShip.create(:name => '(CRV) Corellian Corvette', :price => 1000 ).factions = all
CapitalShip.create(:name => '(CRKC) Carrack Cruiser', :price => 1200 ).factions = imp
CapitalShip.create(:name => '(M/FRG) Nebulon B2 Frigate', :price => 1800 ).factions = imp_reb
CapitalShip.create(:name => '(FRG) Nebulon B Frigate', :price => 1200 ).factions = imp_reb
CapitalShip.create(:name => '(STRKC) Strike Cruiser', :price => 2000 ).factions = imp_reb
CapitalShip.create(:name => 'Radiant IV Cruiser', :price => 1300 ).factions = mand
CapitalShip.create(:name => '(VenSD) Venator Star Destroyer', :price => 5800 ).factions = mand
CapitalShip.create(:name => '(ACC) Acclamator Assault Ship', :price => 5400 ).factions = mand
CapitalShip.create(:name => '(LCB) Lucrehulk Battleship', :price => 20000 ).factions = mand_merc
CapitalShip.create(:name => '(ESC) Escort Carrier', :price => 1900 ).factions = imp
CapitalShip.create(:name => '(INT) Interdictor', :price => 6000 ).factions = imp
CapitalShip.create(:name => '(VSD) Victory Star Destroyer', :price => 5700 ).factions = imp
CapitalShip.create(:name => '(VSD2) Victory Star Destroyer II', :price => 6300 ).factions = imp
CapitalShip.create(:name => '(ISD) Imperial Star Destroyer', :price => 6700 ).factions = imp
CapitalShip.create(:name => '(ISD2) Imperial Star Destroyer II', :price => 7200 ).factions = imp
CapitalShip.create(:name => '(DSD) Dominator Interdictor', :price => 8800 ).factions = imp
CapitalShip.create(:name => '(SSD) Super Star Destroyer', :price => 35000 ).factions = imp

Armament.create(:name => 'Mag Pulse Torpedo', :price => 200 ).factions = all
Armament.create(:name => 'Ion Pulse Torpedo', :price => 100 ).factions = reb
Armament.create(:name => 'Concussion Missile', :price => 100 ).factions = all
Armament.create(:name => 'Proton Torpedo', :price => 75 ).factions = all
Armament.create(:name => 'Adv Missile', :price => 150 ).factions = all
Armament.create(:name => 'Adv Torpedo', :price => 200 ).factions = all
Armament.create(:name => 'Heavy Rocket', :price => 400 ).factions = all
Armament.create(:name => 'Space Bomb', :price => 500 ).factions = all

Armament.create(:name => 'Chaff', :price => 20 ).factions = all
Armament.create(:name => 'Flare', :price => 150 ).factions = all

Trooper.create(:name => 'Trooper', :price => 10 ).factions = all

Facility.create(:name => '(R/PLT) Rebel Platform', :price => 12000 ).factions = reb
Facility.create(:name => '(A/HNG) Asteroid Hangar', :price => 11000 ).factions = mand_merc
Facility.create(:name => '(D/P) Derilyn Platform', :price => 6000 ).factions = mand_merc
Facility.create(:name => '(BASE) Family Base', :price => 7000 ).factions = merc
Facility.create(:name => '(CF/1) Cargo Facility I', :price => 5000 ).factions = all
Facility.create(:name => '(CF/2) Cargo Facility II', :price => 8400 ).factions = all
Facility.create(:name => '(FAC/2) Industrial Complex', :price => 4000 ).factions = all
Facility.create(:name => '(FAC/1) Factory', :price => 8000 ).factions = all
Facility.create(:name => '(G/1) Golan I', :price => 10000 ).factions = all
Facility.create(:name => '(G/2) Golan II', :price => 18000 ).factions = all
Facility.create(:name => '(G/3) Golan III', :price => 24000 ).factions = all
Facility.create(:name => '(PLT/1) Platforms', :price => 8400 ).factions = all
Facility.create(:name => '(IRC) Imperial Research Center', :price => 24000 ).factions = imp
Facility.create(:name => '(SHPYD) Shipyard', :price => 20000 ).factions = all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
    
