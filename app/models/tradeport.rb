class Tradeport < ActiveRecord::Base
  belongs_to :generic_unit
  belongs_to :planet

  def create_units
    Planet.all.each do |planet|
      random_units = []
      random_units << CapitalShip.all    
      random_unit = random_units[rand(random_units.count - 1)]
    end

  end

end
