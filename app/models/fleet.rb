class Fleet < GenericFleet
  belongs_to :destination, :class_name => "Planet"

  def move quantity, planet
    moving_fleet = Fleet.create self.attributes
    moving_fleet.destination = planet
    moving_fleet.quantity = quantity
    moving_fleet.moving = true
    moving_fleet.save
    self.quantity -= quantity
    save
  end

  def move! # TODO nao curti esse metodo. acho que quando efetivar as ordens de movimento tem que somar a quantidade caso ja exista unidades do mesmo tipo no destino.
    self.planet = self.destination
    self.destination = nil
    self.moving = false
    save
  end

  def flee! quantity
    fleeing_fleet = Fleet.create self.attributes
    fleeing_fleet.quantity = quantity
    self.quantity -= quantity
    new_planet = planet.routes.first # TODO redefinir o metodo para pegar primeiro os allied planets
    fleeing_fleet.planet = new_planet
    fleeing_fleet.save
    save
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

