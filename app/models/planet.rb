class Planet < ActiveRecord::Base
  belongs_to :squad
  has_many :fleets

  def credits_per_turn
    if fleets.empty?
      0
    else
      credits
    end
  end
end

