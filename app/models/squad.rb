class Squad < ActiveRecord::Base
  default_scope :order => 'id ASC'

  has_many :planets
  has_many :generic_fleets
  has_many :facility_fleets
  has_many :fleets
  
  def faction=(faction)
    write_attribute(:faction, FACTIONS.rindex(faction))
  end

  def faction
    FACTIONS[read_attribute(:faction)] if read_attribute(:faction)
  end

  def buy unit, quantity, planet
    if (unit.belongs?(faction)) and (unit.is_a? Facility)
      self.credits = self.credits - (unit.price * quantity)
      new_fleet = GenericFleet.create(:generic_unit => unit, :quantity => quantity, :planet => planet)
      generic_fleets << new_fleet
      save
    else
      false
    end
  end

  def generate_profits!
    planets.each do |planet|
      self.credits = self.credits + planet.credits_per_turn
    end
  end

  def change_producing_unit facility_fleet, unit
      self.credits -= 1000 if facility_fleet.producing_unit
      facility_fleet.producing_unit = unit
      facility_fleet.save!
  end
  def end_move_round
    self.move = true
    save
  end

  def random_planet_but planet
    planets_array = planets.to_a - [planet]
    return false if planets_array.empty?
    random_planet = planets_array[rand(planets_array.size)]
  end

  def warp_facility_on_random_planet
    facility_model = Facility.allowed_for(faction).last
    facility_fleets << FacilityFleet.create(:facility => facility_model, :balance => 8000, :planet => planets.first, :quantity => 1)
  end

  def warp_capital_ship_on planet
    capital_ship = Unit.allowed_for(faction).capital_ship.first
    fleets.create(:generic_unit => capital_ship, :planet => planet, :quantity => 1)
  end

  def populate_planets
    planets.each do |planet|
      warp_capital_ship_on planet
      total_value = 5000
      fighter = Unit.allowed_for(faction).fighter.first
      ship_count = 0
      while (total_value > fighter.price)
        ship_count+=1
        total_value -= fighter.price
      end
      fleets.create(:generic_unit => fighter, :planet => planet, :quantity => ship_count)
    end
    save!
  end
end
