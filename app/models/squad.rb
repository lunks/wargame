class Squad < ActiveRecord::Base
  default_scope :order => 'id ASC'

  has_many :planets
  has_many :owned_ships do
    def add_ships_to_pool ship, quantity
      owned_ship = find_or_initialize_by_ship_id_and_planet_id ship.id, nil
      if owned_ship.new_record?
        owned_ship.quantity = quantity
      else
        owned_ship.quantity += quantity
      end
      owned_ship.save!
    end
  end

  has_and_belongs_to_many :ships


  def buy ship, quantity
    if ships.include? ship
      self.credits = self.credits - (ship.price * quantity)
      owned_ships.add_ships_to_pool ship, quantity
      save
    else
      false
    end
  end

  def sell ship, quantity
    selling_ship = owned_ships.where({:ship_id => ship}).first
    self.credits = self.credits + (selling_ship.ship.price * quantity)
    selling_ship.quantity -= quantity
    owned_ships.delete selling_ship if selling_ship.quantity == 0
    save
  end

  def end_move_round
    self.move = true
    save
  end
end

