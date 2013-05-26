class Fleet < GenericFleet

  def move quantity, planet
    if planet == nil
      cancel_moves
      return
    end
    cancel_moves if self.destination.present? && ( self.type?(CapitalShip) || self.type?(LightTransport) || self.type?(Fighter) )  
 
    valid_move = true
    if self.generic_unit.class == Trooper  || self.generic_unit.class == Armament || self.generic_unit.class == Commander
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

  def cancel_moves
    Fleet.where(:squad => self.squad, :moving => true, :planet => self.planet, :destination => self.destination).update_all(:moving => nil, :destination_id => nil)
    group_fleets
  end

  def move!
    unless self.type?(Sensor)
      update_attributes(:planet => destination, :destination => nil, :moving => nil)
    else
      update_attributes(:planet => destination) 
    end
    group_fleets
  end

  def reassembly
    update_attributes(:moving => nil, :destination_id => nil )
  end

  def flee! quantity
    fleeing_fleet = self.clone
    fleeing_fleet.update_attributes(:quantity => quantity, :moving => true, :destination => planet.best_route_for(squad) )
    self.quantity -= quantity
    save
    fleeing_fleet.move!
    fleeing_fleet
  end

  def self.create_from_facility unit, quantity, planet, squad
    if unit.type == 'CapitalShip' || unit.type == 'Sensor'
      quantity.times do
        Fleet.create(:generic_unit_id => unit.id, :planet_id => planet.id, :squad_id => squad.id, :fleet_name => ' ', :quantity => 1)
      end
    else
      fleet = find_or_create_by_generic_unit_id_and_planet_id_and_squad_id(:generic_unit_id => unit.id, :planet_id => planet.id, :squad_id => squad.id, :fleet_name => ' ')
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
      if Fleet.where(:generic_unit_id => fleet.generic_unit.id).count > 1 && fleet.type?(Commander)
         fleet.destroy
      else
         fleet.quantity = 1 if fleet.quantity > 1 && unit.is_a?(Commander)
         fleet.save
      end
   end


  end

  def group_fleets
    unless self.generic_unit.is_a?(CapitalShip) || self.generic_unit.is_a?(Facility)|| self.generic_unit.is_a?(Sensor)
      fleets = planet.generic_fleets.where(:generic_unit_id => self.generic_unit.id, :planet => self.planet, :squad => self.squad, :moving => nil)
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

end

