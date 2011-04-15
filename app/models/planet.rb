class Planet < ActiveRecord::Base
  scope :seen_by, lambda {|squad| joins(:generic_fleets).where(:generic_fleets => {:squad => squad})}
  belongs_to :squad
  has_many :generic_fleets
  belongs_to :ground_squad, :class_name => "Squad"
  @@disable_routes = false

  def credits_per_turn
    if self.squad != nil && self.squad == self.ground_squad
      credits
    else
      0
    end
  end

  def set_ownership
    if has_a? CapitalShip or has_a? Facility
      self.squad = generic_fleets.first.squad
    else
      self.squad = nil
    end
  end

  def set_ground_ownership
    if has_a? Trooper
      self.ground_squad = generic_fleets.first.squad
    else
      self.ground_squad = nil
    end
  end

  def self.randomize
    empty_planets = where(:squad_id => nil).all
    empty_planets[rand(empty_planets.count-1)]
  end

  def self.disable_routes
    @@disable_routes = true
  end

  def self.enable_routes
    @@disable_routes = false
  end

  def has_a?(type)
    generic_fleets.any?{|fleet| fleet.type? type}
  end

  def routes
    return Planet.all if @@disable_routes
    route = Route.where({:vector_a => self} | {:vector_b => self})
    planets = []
    route.each do |route|
      planets << route.vector_a
      planets << route.vector_b
    end
    planets.reject! {|planet| planet == self}
    planets.uniq
  end

  def best_route_for squad
    best_routes = routes.reject {|planet| planet.squad != squad}
    unless best_routes.empty?
      best_routes
    else
      routes
    end
  end

end

