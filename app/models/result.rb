class Result < ActiveRecord::Base

  #attr_accessible :captor_id, :blasted, :captured, :fled

  belongs_to :generic_unit
  belongs_to :planet
  belongs_to :generic_fleet
  belongs_to :squad
  belongs_to :captor, :class_name => "Squad", :foreign_key => 'captor_id'
  belongs_to :round
  belongs_to :producing_unit, :class_name => "Unit"
  belongs_to :producing_unit2, :class_name => "Unit"

  validates_presence_of :round, :generic_fleet, :generic_unit, :squad, :planet, :quantity 
  validates_numericality_of :blasted, :fled, :captured, :allow_nil => true
  validate :captor_if_captured
  validate :posted_results  

  def blast!
    self.generic_fleet.blast! self.blasted
    self.final_quantity = self.quantity - self.blasted
    save
  end

  def flee!
    self.generic_fleet.flee! self.fled if self.generic_fleet.respond_to? :flee!
    self.final_quantity = self.quantity - self.fled
    save
  end

  def capture!
    self.generic_fleet.capture! self.captured, self.captor
    self.squad = self.captor
    save
  end

  def sabotage!
    self.generic_fleet.sabotage! if sabotaged?
  end

  def captor_if_captured
    if self.captured and !captor.is_a?(Squad)
      errors.add :captor, :empty
    else
      true
    end
  end

  def posted_results
    posted_result = self.captured.to_i + self.blasted.to_i + self.fled.to_i
    if posted_result > self.quantity.to_i || posted_result < 0
      errors.add :blasted, 'exceed fleet quantity'
    else
      true
    end
  end

  def show_results
    results = ''
    if self.present?
      results << self.blasted.to_s+'d ' if self.blasted != nil
      results << self.fled.to_s+'f ' if self.fled != nil
      results << self.captured.to_s+'c ' if self.captured != nil
      results << 'sabot' if self.sabotaged == true
    end
    results
  end
  def show
    case generic_unit.type
    when 'CapitalShip'
      "#{generic_unit.name} '#{generic_fleet.fleet_name}'"
    when 'Warrior'
      "#{generic_unit.name} (#{quantity} vidas}"
    when 'Commander'
      "#{generic_unit.name}"
    when 'Sensor'
      unless generic_fleet.moving?
        "#{generic_unit.name} #{'(sabotada)' if sabotaged?}"
      else
        "#{generic_unit.description}"
      end
    when 'Facility'
      unless generic_fleet.moving?
        "#{generic_unit.name} (#{producing_unit.name unless producing_unit == nil} / #{producing_unit2.name unless producing_unit2 == nil})"
      else
        "#{generic_unit.description}"
      end
    else
      "#{quantity} #{generic_unit.name}"
    end

  end

end
