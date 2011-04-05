class Planet < ActiveRecord::Base
  belongs_to :squad
  has_many :generic_fleets

  def credits_per_turn
    if has_a? CapitalShip
      credits
    else
      0
    end
  end

  def set_ownership
    if has_a? CapitalShip
      self.squad = generic_fleets.first.squad
    else
      self.squad = nil
    end
  end

  def self.randomize
    empty_planets = where(:squad_id => nil).all
    empty_planets[rand(empty_planets.count-1)]
  end

  def has_a?(type)
    generic_fleets.any?{|fleet| fleet.type? type}
  end

  def routes
    route = Route.where({:vector_a => self} | {:vector_b => self})
    planets = []
    route.each do |route|
      planets << route.vector_a
      planets << route.vector_b
    end
    planets.reject! {|planet| planet == self}
    planets.uniq
  end

end

