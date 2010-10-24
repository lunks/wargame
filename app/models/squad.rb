class Squad < ActiveRecord::Base
  has_many :planets
  has_many :owned_ships
  has_and_belongs_to_many :ships

  def buy ship, quantity
    if ships.include? ship
      self.credits = self.credits - (ship.price * quantity)
      owned_ships.create!({:ship => ship, :quantity => quantity})
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
  end
end

