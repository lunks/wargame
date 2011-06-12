class Round < ActiveRecord::Base
  def self.getInstance
    if Round.count == 0
      Round.create(:number => 1, :move => true)
    else
      Round.last
    end
  end

  def new_game!
    Squad.all.each do |squad|
      3.times {squad.planets << Planet.randomize}
      squad.populate_planets
    end
    set_map
  end

  def end_moving!
    Squad.all.each do |squad|
      squad.ready = nil
      squad.save
    end
    self.move_fleets
    self.check_conflicts
    self.move = nil
    self.attack = true
    save
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
    moving_fleets = Fleet.where(:moving => true)
    moving_fleets.each do |fleet|
      fleet.move!
    end
  end

  def check_conflicts #TODO criar os post results somente em planetas que tiverem conflito (2 squads no mesmo planeta)
    GenericFleet.all.each do |fleet|
      Result.create(:generic_fleet_id => fleet.id, :planet => fleet.planet, :quantity => fleet.quantity, :generic_unit_id => fleet.generic_unit.id, :round => self, :squad => fleet.squad)
    end
  end

  def apply_results
    Result.where(:round => self).each do |result|
      result.blast! unless result.blasted == nil || result.blasted <= 0
      result.capture! unless result.captured == nil || result.captured <= 0
      result.flee! unless result.fled == nil || result.fled <= 0
    end
  end

end
