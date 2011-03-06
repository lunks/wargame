class Fleet < GenericFleet
  belongs_to :destination, :class_name => "Planet"

  def move quantity, planet
    self.moving = true
    self.destination = planet
  end


end

