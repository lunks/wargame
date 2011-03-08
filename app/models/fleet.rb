class Fleet < GenericFleet
  belongs_to :destination, :class_name => "Planet"

  def move quantity, planet
    self.moving = true
    self.destination = planet
  end
  def flee! quantity
    fleeing_fleet = self.dup
    fleeing_fleet.quantity = quantity
    new_planet = squad.random_planet_but self.planet
    unless new_planet == false
      fleeing_fleet.planet = new_planet
    else
      fleeing_fleet.destroy
      self.destroy
    end
  end

end

