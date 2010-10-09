class OwnedShips < ActiveRecord::Base
  belongs_to :squad
  belongs_to :planet
end
