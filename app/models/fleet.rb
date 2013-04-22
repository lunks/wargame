class Fleet < GenericFleet

  def move quantity, planet
    if planet == nil
      Fleet.where(:squad => self.squad, :moving => true, :planet => self.planet, :destination => self.destination).update_all(:moving => nil, :destination_id => nil)
      return
    end
    Fleet.where(:squad => self.squad, :moving => true, :planet => self.planet, :destination => self.destination).update_all(:moving => nil, :destination_id => nil) if self.destination.present? && ( self.type?(CapitalShip) || self.type?(LightTransport) )   
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
      if planet == nil
        moving_fleet.moving = nil
        moving_fleet.destination = nil
      else
        moving_fleet.moving = true
      end
      moving_fleet.save
      self.quantity -= quantity
      save
      moving_fleet
    else
      self
    end

  end

  def cancel_move
    update_attributes(:destination => nil, :moving => nil)
    group_fleets
  end

  def move!
    update_attributes(:planet => destination, :destination => nil, :moving => nil)
    group_fleets
  end

  def flee! quantity
    routes = planet.routes.select { |planet| planet.squad == self.squad }
    routes = planet.routes.select { |planet| planet.ground_squad == self.squad} if routes.empty?
    routes = planet.routes.select { |planet| planet.squad == nil} if routes.empty?
    routes = planet.routes if routes.empty?
    fleeing_fleet = self.clone
    fleeing_fleet.update_attributes(:quantity => quantity, :moving => true, :destination => routes.first)
    self.quantity -= quantity
    save
    fleeing_fleet.move!
    fleeing_fleet
  end

  def self.create_from_facility unit, quantity, planet, squad
    fleet = find_or_create_by_generic_unit_id_and_planet_id_and_squad_id(:generic_unit_id => unit.id, :planet_id => planet.id, :squad_id => squad.id, :fleet_name => squad.name)
    if fleet.quantity
      fleet.quantity += quantity
    else
      fleet.quantity = quantity
    end
    fleet.save
    if Fleet.where(:generic_unit_id => fleet.generic_unit.id).count > 1 && fleet.type?(Warrior)
       fleet.destroy
    else
       fleet.quantity = 10 if fleet.quantity > 10 && unit.is_a?(Warrior)
       fleet.save
    end
  end

  def group_fleets
    fleets = planet.generic_fleets.where(:generic_unit_id => self.generic_unit.id, :planet => self.planet, :squad => self.squad, :moving => nil, :type => 'Fleet', :fleet_name => self.squad.name)
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

