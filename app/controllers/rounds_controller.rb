class RoundsController < ApplicationController

  def index
    @squads = Squad.all
  end

  def new_game
    @round = Round.getInstance
    @round.new_game!
    @round.number = 1
    @round.move = true
    @round.save
    render :text => 'New Game OK'
  end

  def pass_moving_phase
    @moving_fleets = Fleet.where(:moving => true)
    @moving_fleets.each {|fleet| fleet.move!}
    @round = Round.last
    @round.move = nil
    @round.attack = true
    @round.save
    render :text => 'Pass Moving Phase OK'
  end

  def new_round
    @squads = Squad.all
    @squads.each do |f|
      f.generate_profits!
    end
    last_round = Round.last
    new_round_number = last_round.number + 1
    Round.create(:number => new_round_number, :move => true)
    render :text => 'New Round ok'
  end

end

