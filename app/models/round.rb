class Round < ActiveRecord::Base

  scope :results_seen_by, lambda {|squad| joins(:results).where(:results => {:squad => squad}).group("number")}
  has_many :results

  def self.getInstance
    if Round.count == 0
      Round.create(:number => 1, :move => true)
    else
      Round.last
    end
  end

  def new_game!
    Squad.all.each do |squad|
      home_planet = squad.home_planet
      squad.planets << home_planet
      squad.save
    end
    3.times do
      empty_planets = Planet.where(:squad_id => nil, :wormhole => nil)
      eastside = empty_planets[rand(empty_planets.count - 1)]
      eastside.update_attributes(:wormhole => true)
      empty_planets = Planet.where(:squad_id => nil, :wormhole => nil)
      westside = empty_planets.except(eastside.routes.first)[rand(empty_planets.except(eastside.routes.first).count - 1)]
      westside.update_attributes(:wormhole => true)
      Route.create(:vector_a => eastside, :vector_b => westside, :distance => 1)
    end
    Squad.all.each do |squad|
      2.times {squad.planets << Planet.randomize}
      FacilityFleet.is_free
      squad.populate_planets
      squad.update_attributes(:credits => 1200, :goal => Goal.get_goal)
    end
    GenericFleet.update_all(:level => 0)
    Tradeport.start
    set_map
  end

  def end_moving!
    Squad.update_all(:ready => nil)
    GenericFleet.update_all(:sabotaged => nil)
    self.move_fleets
    self.update_attributes(:move => nil, :attack => true)
    GenericFleet.all.each do |fleet|
      Result.create(:generic_fleet_id => fleet.id, :planet => fleet.planet, :quantity => fleet.quantity, :generic_unit_id => fleet.generic_unit.id, :round => self, :squad => fleet.squad, :final_quantity => fleet.quantity) if fleet.planet.under_attack?
    end
    Planet.all.each do |planet|
      last_player = planet.squads[rand(planet.squads.count)]
      available_squads = planet.squads.reject {|x| x == last_player}
      first_player = available_squads[rand(planet.squads.count - 1)]
      planet.last_player = last_player
      planet.first_player = first_player
      planet.save 
    end
    set_map
  end

  def end_round!
    self.update_attributes(:move => nil, :attack => nil, :done => true)
    self.apply_results
    Round.create(:number => self.number + 1, :move => true)
    Squad.all.each do |squad|
      squad.generate_profits!
      squad.facility_fleets.each do |facility|
        facility.produce!
      end
      squad.ready = nil
      squad.credits -= squad.flee_tax self
      squad.save!
    end
    FacilityFleet.where(:moving => true).each do |facility|
      facility.reassembly unless facility.planet.has_an_enemy?(Facility, facility.squad) || facility.planet.has_an_enemy?(CapitalShip, facility.squad) || facility.planet.has_an_enemy?(Fighter, facility.squad) || facility.planet.has_an_enemy?(LightTransport, facility.squad)
    end
    Fleet.where(:moving => true).each do |fleet|
      fleet.reassembly unless fleet.planet.has_an_enemy?(Facility, fleet.squad) || fleet.planet.has_an_enemy?(CapitalShip, fleet.squad) || fleet.planet.has_an_enemy?(Fighter, fleet.squad) || fleet.planet.has_an_enemy?(LightTransport, fleet.squad)
    end
    Tradeport.start
    set_map
  end

  def set_map
    Planet.all.each do |planet|
      planet.set_ownership
      planet.set_ground_ownership
    end
  end

  def check_state
    squads_not_ready = Squad.where(:ready => nil)
    if Round.getInstance.move?
      Round.getInstance.end_moving! if squads_not_ready.empty?
    else
      Round.getInstance.end_round! if squads_not_ready.empty?
    end
  end

  def move_fleets
    GenericFleet.moving.each(&:move!)
  end

  def apply_results
    Result.where(:round => self).each do |result|
      result.sabotage! unless result.sabotaged == nil
      result.blast! unless result.blasted == nil || result.blasted <= 0
      result.capture! unless result.captured == nil || result.captured <= 0
      result.flee! unless result.fled == nil || result.fled <= 0
    end
  end

end
