class Result < ActiveRecord::Base
  belongs_to :generic_unit
  belongs_to :planet
  belongs_to :generic_fleet
  belongs_to :squad
  belongs_to :captor, :class_name => 'Squad'
  belongs_to :round

  def blast!
    self.generic_fleet.blast! self.blasted
  end
  def flee!
    self.generic_fleet.flee! self.fled if self.generic_fleet.respond_to? :flee!
  end
end
