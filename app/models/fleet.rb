class Fleet < ActiveRecord::Base
  belongs_to :squad
  belongs_to :planet
  belongs_to :unit
  belongs_to :destination, :class_name => "Planet"

  def move quantity, planet
    self.moving = true
    self.destination = planet
  end

  def captured! quantity, squad
    self.quantity = self.quantity - quantity
    self.destroy if self.quantity == 0

    captured_fleet = self.clone
    captured_fleet.squad = squad
    captured_fleet.quantity = quantity
    captured_fleet.save
    
  end
     
end

