class Planet < ActiveRecord::Base
  belongs_to :squad
  has_many :generic_fleets

  def credits_per_turn
    if generic_fleets.empty?
      0
    else
      credits
    end
  end
end

