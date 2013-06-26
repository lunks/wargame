class Fleet < GenericFleet

  def move quantity, planet
    if planet == nil
      cancel_moves
      self
    elsif self.generic_unit.hyperdrive == false || self.type?(Commander) || self.type?(Trooper) || self.type?(Armament)
      self
    else
      moving_fleet = Fleet.new self.attributes
      moving_fleet.destination = planet
      moving_fleet.quantity = quantity
      moving_fleet.moving = true
      moving_fleet.save
      unless self.cargo.empty?
        self.cargo.each do |cargo|
          cargo.moving = moving_fleet.moving 
          cargo.destination = moving_fleet.destination
          cargo.carried_by = moving_fleet
          cargo.save       
        end
      end
      self.quantity -= quantity
      save
      moving_fleet
    end
  end

  def cancel_moves
    GenericFleet.where(:squad => self.squad, :moving => true, :planet => self.planet, :destination => self.destination).update_all(:moving => nil, :destination_id => nil)
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
        Fleet.create(:generic_unit_id => unit.id, :planet_id => planet.id, :squad_id => squad.id, :fleet_name => '', :quantity => 1)
      end
    else
      fleet = find_or_create_by_generic_unit_id_and_planet_id_and_squad_id_and_weapon1_id_and_weapon2_id(:generic_unit_id => unit.id, :planet_id => planet.id, :squad_id => squad.id, :fleet_name => '', :weapon1_id => nil, :weapon2_id => nil)
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

end

