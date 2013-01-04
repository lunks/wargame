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
    unless (unit.belongs? faction) and (unit.is_a? Facility) and (credits >= unit.price)
      return false
    end
    #self.credits = self.credits - (unit.price * quantity)
    new_fleet = FacilityFleet.create(:generic_unit => unit, :quantity => quantity, :planet => planet, :balance => 0, :fleet_name => self.name, :level => 0)
    generic_fleets << new_fleet
    save
  end

  def generate_profits!
    planets.each do |planet|
      self.credits = self.credits + planet.credits_per_turn
      save
    end
  end

  def change_producing_unit facility_fleet, unit
    facility_fleet.producing_unit = unit
    facility_fleet.save!
  end

  def random_planet_but planet
    planets_array = planets.to_a - [planet]
    return false if planets_array.empty?
    random_planet = planets_array[rand(planets_array.size)]
  end

  def warp_facility_on planet
    # cria um facility grande e 1 pequeno
    facility_model_small = Facility.allowed_for(faction).first
    facility = facility_fleets.new(:facility => facility_model_small, :planet => planet, :fleet_name => self.name)
    facility.save!
    facility_model_big = Facility.allowed_for(faction).last
    facility = facility_fleets.new(:facility => facility_model_big, :planet => planet, :fleet_name => self.name)
    facility.save!
  end

  def warp_units total_value, unit, planet
    if unit == CapitalShip
      units = unit.allowed_for(faction).where(:price => 490..510)
    else
      units = unit.allowed_for(faction).where(:price => 1..120)
    end
    random_unit = units[rand(units.size)]
    unit_count = 0
    while (total_value >= random_unit.price)
      unit_count += 1
      total_value -= random_unit.price
    end
    fleet = fleets.new(:generic_unit_id => random_unit.id, :planet => planet, :quantity => unit_count, :fleet_name => self.name, :level => 0)
    fleet.save!
  end

  def populate_planets
    planets.each do |planet|
      warp_units 2000, Fighter, planet
      warp_units 1000, CapitalShip, planet
      warp_units 2000, Fighter, planet
      warp_units 1000, Trooper, planet
      warp_facility_on planet
    end
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
    save
    Round.getInstance.check_state
  end

  def flee_tax round
    tax = 0
    Result.where(:squad => self, :round => round).each do |result|
      tax += result.generic_unit.price * result.fled * 0.20 unless result.fled == nil || result.fled <= 0
    end
    tax
  end

end
