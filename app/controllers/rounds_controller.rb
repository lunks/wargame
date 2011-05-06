class RoundsController < ApplicationController

  def index
    @squads = Squad.all
  end

  def new_game
    @round = Round.getInstance.new_game!
    render :text => 'New Game OK'
  end

  def end_moving_phase
    round = Round.getInstance.end_moving_phase!
    render :text => 'Pass Moving Phase OK'
  end

  def end_round
    round = Round.getInstance.end_round!
    render :text => 'New Round ok'
  end

end

