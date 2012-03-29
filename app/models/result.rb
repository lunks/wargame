class Result < ActiveRecord::Base

  #attr_accessible :captor_id, :blasted, :captured, :fled

  belongs_to :generic_unit
  belongs_to :planet
  belongs_to :generic_fleet
  belongs_to :squad
  belongs_to :captor, :class_name => "Squad", :foreign_key => 'captor_id'
  belongs_to :round

  validates_presence_of :round, :generic_fleet, :generic_unit, :squad, :planet, :quantity 
  validates_numericality_of :blasted, :fled, :captured, :allow_nil => true
  validate :captor_if_captured  

  def blast!
    self.generic_fleet.blast! self.blasted
  end

  def flee!
    self.generic_fleet.flee! self.fled if self.generic_fleet.respond_to? :flee!
  end

  def capture!
    self.generic_fleet.capture! self.captured, self.captor
  end

  def captor_if_captured
    if self.captured and !captor.is_a?(Squad)
      errors.add :captor, :empty
    else
      true
    end
  end

end
