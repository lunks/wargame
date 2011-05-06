class RoundsController < ApplicationController

  def index
    @squads = Squad.all
  end

  def new_game
    require 'generic_unit'
    @round = Round.getInstance.new_game!
    @round.number = 1
    @round.move = true
    @round.save
  end

  def pass_moving_phase
    @moving_fleets = Fleet.where(:moving => true)
    @moving_fleets.each {|fleet| fleet.move!}
    @round = Round.getInstance
    @round.move = nil
    @round.attack = true
  end

  def new_round
    @squads = Squad.all
    @squads.each do |f|
      f.generate_profits!
    end
    last_round = Round.getInstance
    new_round_number = last_round.number + 1
    Round.create(:number => last_round_number, :move => true)
  end

end

