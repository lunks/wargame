class RoundsController < ApplicationController

  def index
    @squads = Squad.all
    @user = User.last
  end

  def new_game
    @round = Round.getInstance.new_game!
    render :text => 'New Game OK'
  end

  def end_moving
    round = Round.getInstance.end_moving!
    render :text => 'Pass Moving Phase OK'
  end

  def end_round
    round = Round.getInstance.end_round!
    render :text => 'New Round ok'
  end

  def delete_usuario
     User.last
  end

end

