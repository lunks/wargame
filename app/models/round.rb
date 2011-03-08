class Round < ActiveRecord::Base
  def self.getInstance
    Round.last
  end

  def done_moving?
    done = true
    Squad.all.each do |squad|
      done = false if squad.move.blank?
    end
    save
    done
  end

  def who?
    Squad.all.each do |squad|
      return squad if squad.move? == false
    end
  end

  def new_game!
    Squad.all.each do |squad|
      3.times {squad.planets << Planet.randomize}
      facility_model = squad.facilities.last
      facility = FacilityFleet.create(:facility => facility_model, :balance => 7500)
      squad.facility_fleets << facility
      unit = squad.units.where("price >= ?", 350).first
      capital_ship = squad.units.where(:price => 2500..3200).first
      squad.planets.each do |planet|
        squad.fleets.create(:generic_unit => capital_ship, :planet => planet, :quantity => 1)
        total_value = 5000
        ship_count = 0
        while total_value > unit.price
          ship_count++
          total_value -= unit.price
        end
        squad.fleets.create(:generic_unit => unit, :planet => planet, :quantity => ship_count)
      end
    end
  end
end

