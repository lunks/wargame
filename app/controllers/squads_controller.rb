class SquadsController < ApplicationController

  def new
    @squad = Squad.new
    @colors = %w[FF0000 00FF00 FFFF00 00FFFF FFFFFF EE82EE]
    @planets = Planet.all
  end

  def create
    squad = Squad.create(params[:squad])
    current_user.squad = squad
    squad.credits = 0
    squad.save
    redirect_to fleets_path
  end

  def ready
    redirect_to fleets_path if current_squad.ready!
  end

  def transfer
    @squad = current_squad
    @squads = Squad.all
  end

  def transfer_credits
    unless params[:transfer][:credits].empty? || params[:transfer][:squad].empty?
      @squad_destination = Squad.find(params[:transfer][:squad])
      @quantity = (params[:transfer][:credits]).to_i
      current_squad.transfer_credits @quantity, @squad_destination
      redirect_to :back
    end
  end

  def goal
    @squad = Squad.find(params[:id])
    @goal = @squad.goal
    @goals = Goal.all
  end


end

