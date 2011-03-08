class Squad < ActiveRecord::Base
  default_scope :order => 'id ASC'

  has_many :planets
  has_many :generic_fleets
  has_many :facility_fleets
  has_many :fleets
  has_and_belongs_to_many :facilities, :join_table => :generic_units_squads, :association_foreign_key => :generic_unit_id
  has_and_belongs_to_many :units, :join_table => :generic_units_squads, :association_foreign_key => :generic_unit_id do
    def fighter
      where("price >= ?", 350).first
    end

    def capital_ship
      where(:price => 2500..3500).first
    end
  end
  has_and_belongs_to_many :generic_units


  def buy unit, quantity, planet
    if facilities.include?(unit)
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
    if facility_fleet.producing_unit.nil?
   else
      self.credits -= 1000
   end
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
    facility_model = facilities.last
    facility_fleets << FacilityFleet.create(:facility => facility_model, :balance => 7500, :planet => planets.first)
  end

  def warp_capital_ship_on planet
    capital_ship = units.capital_ship
    fleets.create(:generic_unit => capital_ship, :planet => planet, :quantity => 1)
  end

  def populate_planets
    planets.each do |planet|
      warp_capital_ship_on planet
      total_value = 5000
      fighter = units.fighter
      ship_count = 0
      while (total_value > fighter.price)
        ship_count++
        total_value -= fighter.price
      end
      fleets.create(:generic_unit => fighter, :planet => planet, :quantity => ship_count)
    end
    save!
  end
end
