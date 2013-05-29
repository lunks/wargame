class Squad < ActiveRecord::Base

  default_scope :order => 'id ASC'

  has_many :planets
  has_many :generic_fleets
  has_many :facility_fleets
  has_many :fleets
  belongs_to :goal
  belongs_to :home_planet, :class_name => "Planet"

  def faction=(faction)
    write_attribute(:faction, FACTIONS.rindex(faction))
  end

  def faction
    FACTIONS[read_attribute(:faction)] if read_attribute(:faction)
  end

  def buy unit, quantity, planet
    unless (unit.belongs? faction) and (unit.is_a? Facility) and (credits >= unit.price)
      return false
    end
    debit unit.price
    new_fleet = FacilityFleet.create(:generic_unit => unit, :quantity => quantity, :planet => planet, :fleet_name => ' ')
    generic_fleets << new_fleet
    save
  end

  def generate_profits!
    income = 0
    Planet.where(:squad => self).each do |planet|
      income += planet.air_credits if planet.air_credits.present?
    end
    Planet.where(:ground_squad => self).each do |planet|
      income += planet.ground_credits if planet.ground_credits.present?
    end
    self.credits += income
    save
  end

  def change_producing_unit facility_fleet, unit
    facility_fleet.producing_unit = unit
    facility_fleet.save!
  end

  def change_producing_unit2 facility_fleet, unit
    facility_fleet.producing_unit2 = unit
    facility_fleet.save!
  end

  def random_planet_but planet
    planets_array = planets.to_a - [planet]
    return false if planets_array.empty?
    random_planet = planets_array[rand(planets_array.size)]
  end

  def warp_facility_on planet
    facility_model_small = Facility.allowed_for(faction).first
    facility = facility_fleets.new(:facility => facility_model_small, :planet => planet, :balance => 0, :level => 0, :fleet_name => ' ')
    facility.save!
    facility_model_big = Facility.allowed_for(faction).last
    facility = facility_fleets.new(:facility => facility_model_big, :planet => planet, :balance => 0, :level => 0, :fleet_name => ' ')
    facility.save!
  end

  def warp_units total_value, unit, allowed_price, planet
      units = unit.allowed_for(faction).where(:price => allowed_price)
      random_unit = units[rand(units.size)]
      unit_count = 0
      while (total_value >= random_unit.price)
        unit_count += 1
        total_value -= random_unit.price
      end
      fleet = fleets.new(:generic_unit_id => random_unit.id, :planet => planet, :quantity => unit_count, :fleet_name => ' ')
    fleet.save!
  end

  def populate_planets
    planets.each do |planet|
      warp_facility_on planet
      warp_units 600, CapitalShip, 500..600, planet
      warp_units 600, CapitalShip, 500..600, planet
      warp_units 200, LightTransport, 50..100, planet
      warp_units 2000, Fighter, 1..120, planet
      warp_units 2000, Fighter, 1..120, planet
      warp_units 1000, Trooper, 1..2, planet
    end
    warp_units 500, Warrior, 50, planets.first
    warp_units 450, Warrior, 45, planets.last
    warp_units 1000, Commander, 1000, planets.first
    warp_units 800, Commander, 800, planets.last
    mid_planet = planets.select { |planet| !planet.generic_fleets.any? { |unit| unit.type?(Warrior) } }
    warp_units 400, Warrior, 40, mid_planet.first
    save!
  end

  def transfer_credits quantity, destination
    if self.credits >= quantity && self != destination
      self.debit quantity
      destination.deposit quantity
    end
  end

  def debit quantity
    update_attributes(:credits => credits - quantity)
  end

  def deposit quantity
    update_attributes(:credits => credits + quantity)
  end

  def ready!
    self.ready = true
    self.save!
    Round.getInstance.check_state
    true
  end

  def flee_tax round
    tax = 0
    Result.where(:squad => self, :round => round).each do |result|
      tax += result.generic_unit.price * result.fled * 0.20 unless result.fled == nil || result.fled <= 0
    end
    tax
  end

end
