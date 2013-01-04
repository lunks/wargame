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
      squad.planets << Planet.where(:name => 'BrNavies Spaceport') and famous_squad = true if squad.name == 'BRR'
      if famous_squad == true
        squad.planets << Planet.randomize
      else
        2.times {squad.planets << Planet.randomize}
      end
      FacilityFleet.is_free
      squad.populate_planets
      squad.update_attributes(:credits => 1200)
    end
    GenericFleet.update_all(:level => 0)
    #cria 2 rotas pra 2 wormholes diferente dos planetas ocupados
    wormhole = Planet.where(:name => 'Wormhole I').first
    wormhole2 = Planet.where(:name => 'Wormhole II').first
    2.times {Route.create(:vector_a => wormhole, :vector_b => Planet.randomize, :distance => 1)}
    2.times {Route.create(:vector_a => wormhole2, :vector_b => Planet.randomize, :distance => 1)}
    set_map
  end

  def end_moving!
    Squad.update_all(:ready => nil)
    GenericFleet.update_all(:sabotaged => nil)
    self.move_fleets
    self.move = nil
    self.attack = true
    save
    GenericFleet.all.each do |fleet|
      Result.create(:generic_fleet_id => fleet.id, :planet => fleet.planet, :quantity => fleet.quantity, :generic_unit_id => fleet.generic_unit.id, :round => self, :squad => fleet.squad) if fleet.planet.under_attack?
    end
    set_map
  end

  def end_round!
    self.apply_results
    self.attack = nil
    self.done = true
    save
    Round.create(:number => self.number + 1, :move => true)
    set_map
    Squad.all.each do |squad|
      squad.generate_profits!
      squad.facility_fleets.each do |facility|
        facility.produce!
      end
      squad.ready = nil
      squad.credits -= squad.flee_tax self
      squad.save
    end
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
    Fleet.moving.each(&:move!)
  end

  def apply_results
    Result.where(:round => self).each do |result|
      result.blast! unless result.blasted == nil || result.blasted <= 0
      result.capture! unless result.captured == nil || result.captured <= 0
      result.flee! unless result.fled == nil || result.fled <= 0
      result.sabotage! unless result.sabotaged == nil || result.sabotaged <= 0
    end
  end

end
