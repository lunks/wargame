class Planet < ActiveRecord::Base
  belongs_to :squad
  has_many :owned_ships

  def credits_per_turn
    if owned_ships.empty?
      0
    else
      credits
    end
  end
end

