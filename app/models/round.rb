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
      squad.warp_facility_on_random_planet
      squad.populate_planets
    end
  end

  def end_moving_phase!
  end

end
