class Planet < ActiveRecord::Base
  default_scope :order => "name ASC"
  scope :seen_by, lambda {|squad| joins(:generic_fleets).where(:generic_fleets => {:squad => squad}).group("planets.id")}
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
      air_units = generic_fleets.select {|fleet| fleet.type? Facility}
      air_units = generic_fleets.select {|fleet| fleet.type? CapitalShip} if air_units.empty?
      air_units.sort! { |one,other| one.updated_at <=> other.updated_at }
      self.squad = air_units.first.squad
      save
    else
      self.squad = nil
      save
    end
  end

  def set_ground_ownership
    if has_a? Trooper
      ground_units = generic_fleets.select {|fleet| fleet.type? Trooper}
      ground_units.sort! { |one,other| one.updated_at <=> other.updated_at }
      self.ground_squad = ground_units.first.squad
      save
    else
      self.ground_squad = nil
      save
    end
  end

  def self.randomize
      empty_planets = self.where(:squad_id => nil, :wormhole => nil)
      empty_planets[rand(empty_planets.count - 1)]
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

  def squads
    squads = []
    generic_fleets.each do |fleet|
      squads << fleet.squad 
    end
    squads.uniq
  end

  def to_s
    name
  end

  def under_attack?
    if GenericFleet.where(:planet => self).count(:all, :group => :squad).count > 1
      true
    else
      false
    end
  end

end

