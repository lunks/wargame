class Squad < ActiveRecord::Base
  has_many :planets
  has_and_belongs_to_many :ships
  def buy ship
    if self.ships.include? ship
      self.credits = self.credits - ship.price
    else
      false
    end
  end
end

