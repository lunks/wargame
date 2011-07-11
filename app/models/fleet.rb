class Fleet < GenericFleet
  belongs_to :destination, :class_name => "Planet"

  def move quantity, planet
    valid_move = true
    if self.generic_unit.class == Trooper  || self.generic_unit.class == Armament
      moving_fleets = Fleet.where(:planet => self.planet, :destination => planet, :squad => self.squad, :moving => true)
      unit_count = 0
      moving_fleets.each do |fleet|
        unit_count += fleet.quantity if fleet.generic_unit.class == Fighter
      end  
      valid_move = false unless moving_fleets.any? { |fleet| fleet.generic_unit.class == CapitalShip || fleet.generic_unit.class == LightTransport } || unit_count >= quantity
    end
    if self.generic_unit.hyperdrive == false
      moving_fleets = Fleet.where(:planet => self.planet, :destination => planet, :squad => self.squad, :moving => true)
      valid_move = false unless moving_fleets.any? { |fleet| fleet.generic_unit.class == CapitalShip }
    end
    if valid_move == true
      moving_fleet = Fleet.new self.attributes
      moving_fleet.destination = planet
      moving_fleet.quantity = quantity
      moving_fleet.moving = true
      moving_fleet.save
      self.quantity -= quantity
      save
      moving_fleet
    else
      self
    end

  end

  def cancel_move
    self.destination = nil
    self.moving = nil
    save
    group_fleets
  end

  def move!
    self.planet = self.destination
    self.destination = nil
    self.moving = nil
    save
    group_fleets
  end

  def flee! quantity
    routes = planet.routes.select { |planet| planet.squad == self.squad }
    routes = planet.routes if routes.empty?
    fleeing_fleet = Fleet.new self.attributes
    fleeing_fleet.destination = routes.first
    fleeing_fleet.quantity = quantity
    fleeing_fleet.moving = true
    fleeing_fleet.save
    self.quantity -= quantity
    save
    fleeing_fleet.move!
    fleeing_fleet
  end

  def self.create_from_facility unit, quantity, planet, squad
    fleet = find_or_create_by_generic_unit_id_and_planet_id_and_squad_id(:generic_unit_id => unit.id, :planet_id => planet.id, :squad_id => squad.id)
    if fleet.quantity
      fleet.quantity += quantity
    else
      fleet.quantity = quantity
    end
    fleet.save
  end

  def group_fleets
    fleets = planet.generic_fleets.where(:generic_unit_id => self.generic_unit.id, :planet => self.planet, :squad => self.squad, :moving => nil )
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

