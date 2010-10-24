class OwnedShip < ActiveRecord::Base
  belongs_to :squad
  belongs_to :planet
  belongs_to :ship
  belongs_to :destination, :class_name => "Planet"

  def move quantity, planet
    self.moving = true
    self.destination = planet
  end
end

