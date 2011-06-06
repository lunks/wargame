class Round < ActiveRecord::Base
  def self.getInstance
    if Round.count == 0
      Round.create(:number => 1, :move => true)
    else
      Round.last
    end
  end

  def done_moving?
    done = true
    Squad.all.each do |squad|
      done = false unless squad.move?
    end
    save
    done
  end

  def who?
    Squad.all.each do |squad|
      return squad unless squad.move?
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
      squad.move = nil
      squad.save
    end
    moving_fleets = Fleet.where(:moving => true)
    moving_fleets.each do |fleet|
      fleet.move!
    end
    GenericFleet.all.each do |fleet|
      Result.create(:generic_fleet_id => fleet.id, :planet => fleet.planet, :quantity => fleet.quantity, :generic_unit_id => fleet.generic_unit.id, :round => self, :squad => fleet.squad)
    end
    self.move = nil
    self.attack = true
    save
    set_map
  end

  def end_round!
    Result.where(:round => self).each do |result|
      result.blast! unless result.blasted == nil || result.blasted <= 0
      result.capture! unless result.captured == nil || result.captured <= 0
      result.flee! unless result.fled == nil || result.fled <= 0
    end
    self.attack = nil
    self.done = true
    save
    new_round_number = self.number + 1
    Round.create(:number => new_round_number, :move => true)
    set_map
    Squad.all.each do |squad|
      squad.generate_profits!
      squad.facility_fleets.each do |facility|
        facility.produce!
      end
      squad.move = nil
      squad.save
    end
  end

  def set_map
    Planet.all.each do |planet|
      planet.set_ownership
      planet.set_ground_ownership
    end
  end
end
