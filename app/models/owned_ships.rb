class OwnedShips < ActiveRecord::Base
  belongs_to :squad
  belongs_to :planet
  belongs_to :ship

end

