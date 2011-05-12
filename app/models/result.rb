class Result < ActiveRecord::Base
  belongs_to :generic_unit
  belongs_to :planet
  belongs_to :generic_fleet
  belongs_to :squad
  belongs_to :round

  def blast!
    self.generic_fleet.blast! self.blasted
  end
end
