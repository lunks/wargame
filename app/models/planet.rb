class Planet < ActiveRecord::Base
  belongs_to :squad
  has_many :owned_ships
end

