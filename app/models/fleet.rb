class Fleet < GenericFleet
  belongs_to :destination, :class_name => "Planet"

  def move quantity, planet
    self.moving = true
    self.destination = planet
  end



  def flee! quantity # nao consegui terminar...
    fleeing_fleet = Fleet.create self.attributes
    fleeing_fleet.quantity = quantity
    fleeing_fleet.save
    new_planet = fleeing_fleet.planet.routes.first # redefinir o metodo para pegar primeiro os allied planets
    fleeing_fleet.planet = new_planet
    fleeing_fleet.save
    self.quantity -= quantity
    self.save
  end

  def self.create_from_facility unit, quantity, planet
    fleet = find_or_create_by_generic_unit_id_and_planet_id(:generic_unit_id => unit.id, :planet_id => planet.id)
    if fleet.quantity
      fleet.quantity += quantity
    else
      fleet.quantity = quantity
    end
    fleet.save
  end

end

