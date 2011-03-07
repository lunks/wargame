class Squad < ActiveRecord::Base
  default_scope :order => 'id ASC'

  has_many :planets
  has_many :generic_fleets
  has_many :facility_fleets, :class_name => "FacilityFleet", :foreign_key => :generic_fleet_id
  has_and_belongs_to_many :facilities, :join_table => :generic_units_squads, :association_foreign_key => :generic_unit_id
  has_and_belongs_to_many :units, :join_table => :generic_units_squads, :association_foreign_key => :generic_unit_id
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
end

