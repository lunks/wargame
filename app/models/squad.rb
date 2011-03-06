class Squad < ActiveRecord::Base
  default_scope :order => 'id ASC'

  has_many :planets
  has_many :generic_fleets do
    def add_units_to_pool unit, quantity
      fleet = find_or_initialize_by_generic_unit_id_and_planet_id unit.id, nil
      if fleet.new_record?
        fleet.quantity = quantity
      else
        fleet.quantity += quantity
      end
      fleet.save!
    end
  end

  has_and_belongs_to_many :generic_units


  def buy unit, quantity
    if generic_units.include? unit
      self.credits = self.credits - (unit.price * quantity)
      generic_fleets.add_units_to_pool unit, quantity
      save
    else
      false
    end
  end

  def sell unit, quantity
    selling_unit = generic_fleets.where({:generic_unit_id => unit}).first
    self.credits = self.credits + (selling_unit.generic_unit.price/2 * quantity)
    selling_unit.quantity -= quantity
    generic_fleets.delete selling_unit if selling_unit.quantity == 0
    save
  end

  def generate_profits!
    planets.each do |planet|
      self.credits = self.credits + planet.credits_per_turn
    end
  end

  def end_move_round
    self.move = true
    save
  end
end

