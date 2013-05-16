class Planet < ActiveRecord::Base
  default_scope :order => "name ASC"
  scope :seen_by, lambda {|squad| joins(:generic_fleets).where(:generic_fleets => {:squad => squad}).group("planets.id")}
  scope :fog_seen_by, lambda {|squad| joins(:results).where(:results => {:squad => squad}).group("planets.id")}

  belongs_to :squad
  has_many :generic_fleets
  has_many :results
  belongs_to :ground_squad, :class_name => "Squad"
  belongs_to :first_player, :class_name => "Squad"
  belongs_to :last_player, :class_name => "Squad"
  @@disable_routes = false

  def credits_per_turn
    (self.air_credits + self.ground_credits).to_i
  end

  def air_credits
   return (self.credits * 0.50).to_i unless self.squad == nil or generic_fleets.any?{|fleet| fleet.squad != self.squad}
   0
  end

  def ground_credits
   return (self.credits * 0.50).to_i unless self.ground_squad == nil or generic_fleets.any?{|fleet| fleet.squad != self.ground_squad}
   0
  end

  def set_ownership
    if has_a? Facility
      air_units = generic_fleets.select {|fleet| fleet.type? Facility and !fleet.moving?}
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
      empty_planets = self.where(:squad_id => nil, :wormhole => nil, :tradeport => nil)
      empty_planets[rand(empty_planets.count - 1)]
  end

  def self.disable_routes
    @@disable_routes = true
  end

  def self.enable_routes
    @@disable_routes = false
  end

  def has_a?(type)
    generic_fleets.any?{|fleet| fleet.type? type and fleet.moving != true}
  end

  def has_an_enemy?(type, current_squad)
    generic_fleets.any?{|fleet| fleet.type? type and fleet.squad != current_squad}
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

  def best_route_for(squad)
    routes = self.routes.select { |planet| planet.squad == squad }
    routes = self.routes.select { |planet| planet.ground_squad == squad} if routes.empty?
    routes = self.routes.select { |planet| planet.squad == nil} if routes.empty?
    routes = self.routes if routes.empty?
    routes.first



  #  best_routes = routes.reject {|planet| planet.squad != squad}
   # unless best_routes.empty?
    #  best_routes
   # else
    #  routes
   # end
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

  def able_to_construct?(squad)
    if !has_a? Trooper or generic_fleets.any?{|fleet| fleet.squad != squad} or self.tradeport?
      nil
    else
      true
    end
  end

end

