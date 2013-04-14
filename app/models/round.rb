class Round < ActiveRecord::Base
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
      squad.planets << Planet.where(:name => 'RES Station') and famous_squad = true if squad.name == 'RES'
      squad.planets << Planet.where(:name => 'CIMF Station') and famous_squad = true if squad.name == 'CIMF'
      squad.planets << Planet.where(:name => 'BrR Clan Tradeport') and famous_squad = true if squad.name == 'BRR'
      if famous_squad == true
        2.times {squad.planets << Planet.randomize}
      else
        3.times {squad.planets << Planet.randomize}
      end
      FacilityFleet.is_free
      squad.populate_planets
      squad.update_attributes(:credits => 1200, :goal => Goal.get_goal)
    end
    GenericFleet.update_all(:level => 0)

    3.times do
      empty_planets = Planet.where(:squad_id => nil, :wormhole => nil)
      eastside = empty_planets[rand(empty_planets.count - 1)]
      eastside.update_attributes(:wormhole => true)
      empty_planets = Planet.where(:squad_id => nil, :wormhole => nil)
      westside = empty_planets.except(eastside.routes.first)[rand(empty_planets.except(eastside.routes.first).count - 1)]
      westside.update_attributes(:wormhole => true)
      Route.create(:vector_a => eastside, :vector_b => westside, :distance => 1)
    end
    set_map
    2.times { Tradeport.start }
  end

  def end_moving!
    Squad.update_all(:ready => nil)
    FacilityFleet.update_all(:sabotaged => nil)
    self.move_fleets
    self.update_attributes(:move => nil, :attack => true)
    GenericFleet.all.each do |fleet|
      Result.create(:generic_fleet_id => fleet.id, :planet => fleet.planet, :quantity => fleet.quantity, :generic_unit_id => fleet.generic_unit.id, :round => self, :squad => fleet.squad) if fleet.planet.under_attack?
    end
    Planet.all.each do |planet|
      planet.last_player = planet.squads[rand(planet.squads.count)]
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
        facility.produce! unless facility.moving? or facility.planet.tradeport?
      end
      squad.ready = nil
      squad.credits -= squad.flee_tax self
      squad.save!
    end
    FacilityFleet.where(:moving => true).each do |facility|
      facility.reassembly unless facility.planet.under_attack?
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
