class GenericFleetsController < ApplicationController
  def index
    @planets = Planet.seen_by(current_squad)
  end
end
