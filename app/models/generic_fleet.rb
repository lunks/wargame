class GenericFleet < ActiveRecord::Base
  default_scope :order => "squad_id ASC, moving ASC, destination_id ASC, generic_unit_id ASC, updated_at DESC"
  scope :owned_by, lambda {|squad| where(:squad => squad)}
  scope :moving, where(:moving => true)
  belongs_to :squad
  belongs_to :planet
  belongs_to :generic_unit
  belongs_to :destination, :class_name => "Planet"
  belongs_to :carried_by, :class_name => "GenericFleet"
  belongs_to :weapon1, :class_name => "Armament"
  belongs_to :weapon2, :class_name => "Armament"

  after_save :destroy_if_empty

  delegate :name, :to => :generic_unit

  def blast! quantity
    self.quantity -= quantity
    save
  end

  def capture! quantity, squad
    FacilityFleet.is_free
    captured_fleet = self.clone
    captured_fleet.update_attributes(:squad => squad, :quantity => quantity, :type => self.type, :level => self.level, :fleet_name => ' ')
    if captured_fleet.is_a? FacilityFleet
      captured_fleet.balance = 0 - self.capacity 
      captured_fleet.producing_unit2 = nil
    end
    captured_fleet.save
    self.quantity = self.quantity - quantity
    save
  end

  def sabotage!
    self.sabotaged = true
    self.save
  end


  def type?(type)
    generic_unit.is_a? type
  end

  def destroy_if_empty
    destroy if self.quantity == 0
  end

  def to_s
    name
  end

  def change_fleet_name name
    self.fleet_name = name
    save
  end

  def show_results
    round = Round.getInstance
    result = Result.where(:generic_fleet => self, :round => round).first
    results = ''
    if result.present? && round.attack?
      results << result.blasted.to_s+'d ' if result.blasted != nil
      results << result.fled.to_s+'f ' if result.fled != nil
      results << result.captured.to_s+'c ' if result.captured != nil
      results << 'sabot' if result.sabotaged == true
    end
    results
  end

  def to_label
    selling_price = (generic_unit.price * 0.50).to_i
    "#{quantity} #{name} - #{selling_price} cada"
  end

  def show
    case generic_unit.type
    when 'CapitalShip'
      "#{name} '#{fleet_name}'"
    when 'Warrior'
      "#{name} (#{quantity} vidas)"
    when 'Commander'
      "#{name}"
    when 'Sensor'
      unless moving?
        "#{name} #{'(sabotada)' if sabotaged?}"
      else
        "#{generic_unit.description}"
      end
    when 'Facility'
      unless moving?
        "#{name} (#{producing_unit.name unless producing_unit == nil} / #{producing_unit2.name unless producing_unit2 == nil})"
      else
        "#{generic_unit.description}"
      end
    else
       unless weapon1_id
         "#{quantity} #{name}"
       else
         "#{quantity} #{name} + #{weapon1.name}"
       end
    end
  end

  def load_in carrier, qtt
    if qtt == self.quantity
      self.carried_by = carrier
      self.moving = carrier.moving
      self.destination = carrier.destination
      self.save
      self.group_fleets
    else
      not_loaded_fleet = self.clone
      not_loaded_fleet.quantity -= qtt
      not_loaded_fleet.save
      self.carried_by = carrier
      self.quantity = qtt
      self.moving = carrier.moving
      self.destination = carrier.destination
      self.save 
      self.group_fleets     
    end
  end

  def unload_from carrier, qtt
    if qtt == self.quantity
      self.carried_by = nil
      self.moving = nil
      self.destination = nil
      self.save
      self.group_fleets
    else
      unloaded_fleet = self.clone
      unloaded_fleet.quantity = qtt
      unloaded_fleet.carried_by = nil
      unloaded_fleet.moving = nil
      unloaded_fleet.destination = nil
      unloaded_fleet.save
      self.quantity -= qtt
      self.moving = carrier.moving
      self.destination = carrier.destination
      self.save
      unloaded_fleet.group_fleets         
    end
  end

  def carrier
    carried_by
  end

  def cargo
    GenericFleet.where(:carried_by_id => self.id)
  end

  def arm_with armament
    if armament.quantity == self.quantity
      self.update_attributes(:weapon1 => armament.generic_unit)
      armament.update_attributes(:quantity => armament.quantity - self.quantity)
    elsif armament.quantity > self.quantity
      self.update_attributes(:weapon1 => armament.generic_unit)
      armament.update_attributes(:quantity => armament.quantity - self.quantity)
    else
      not_armed_fleet = self.clone
      not_armed_fleet.quantity -= armament.quantity
      not_armed_fleet.save!
      self.update_attributes(:weapon1 => armament.generic_unit, :quantity => armament.quantity)
      armament.update_attributes(:quantity => 0)     
    end
  end

  def disarm
    discharged_armaments = self.clone
    discharged_armaments.generic_unit_id = self.weapon1.id
    discharged_armaments.moving = nil
    discharged_armaments.destination = nil
    discharged_armaments.weapon1 = nil
    discharged_armaments.weapon2 = nil
    discharged_armaments.save!
    self.update_attributes(:weapon1 => nil, :weapon2 => nil)
    discharged_armaments.group_fleets
  end

  def group_fleets
    unless self.generic_unit.is_a?(CapitalShip) || self.generic_unit.is_a?(Facility) || self.generic_unit.is_a?(Sensor) || self.generic_unit.is_a?(LightTransport)
      fleets = planet.generic_fleets.where(:generic_unit_id => self.generic_unit_id, :planet => self.planet, :squad => self.squad, :moving => self.moving, :destination_id => self.destination_id, :carried_by_id => self.carried_by_id, :weapon1_id => self.weapon1_id, :weapon2_id => self.weapon2_id)
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
