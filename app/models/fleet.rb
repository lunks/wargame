class Fleet < ActiveRecord::Base
  belongs_to :squad
  belongs_to :planet
  belongs_to :unit
  belongs_to :destination, :class_name => "Planet"

  def move quantity, planet
    self.moving = true
    self.destination = planet
  end

  def capture squad
    Fleet.update({:squad_id => squad})
    save
  end
     
end

