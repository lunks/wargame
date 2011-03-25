class Fleet < GenericFleet
  belongs_to :destination, :class_name => "Planet"

  def move quantity, planet # Troquei Fleet.create por Fleet.new pois estava criando 2 fleets diferentes.
    moving_fleet = Fleet.new self.attributes
    moving_fleet.destination = planet
    moving_fleet.quantity = quantity
    moving_fleet.moving = true
    moving_fleet.save
    self.quantity -= quantity
    save
    moving_fleet
  end

  def move!
    self.planet = self.destination
    self.destination = nil
    self.moving = nil
    save
    group_fleets
  end

  def flee! quantity
    fleeing_fleet = move quantity, planet.routes.first
    fleeing_fleet.move!
    fleeing_fleet
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

  def group_fleets
    fleets = planet.generic_fleets.where(:generic_unit => self.generic_unit, :planet => self.planet, :squad => self.squad, :moving => nil )
    total_quantity = 0
    fleets.each do |fleet|
      unless fleet == self
        total_quantity += fleet.quantity
        fleet.quantity = 0
        fleet.save
      end
    end
    self.quantity += total_quantity
    save
  end

end

