class Round < ActiveRecord::Base
  def self.getInstance
    if Round.count == 0
      Round.create
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
    self.number = 1
    self.move = true
    save
  end

  def end_moving_phase!
    moving_fleets = Fleet.where(:moving => true)
    moving_fleets.each {|fleet| fleet.move!}
    self.move = nil
    self.attack = true
    save
  end

  def end_round!
    Squad.all.each do |squad|
      squad.generate_profits!
      squad.facility_fleets.each do |facility|
        facility.produce!
      end
    end
    self.attack = nil
    self.done = true
    save
    new_round_number = self.number + 1
    Round.create(:number => new_round_number, :move => true)
  end
end
