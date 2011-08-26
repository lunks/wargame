class SquadsController < ApplicationController

  def new
    @squad = Squad.new
    @colors = %w[FF0000 00FF00 FFFF00 0000FF FFFFFF EE82EE]
  end

  def create
    squad = Squad.create(params[:squad])
    current_user.squad = squad
    squad.credits = 0
    squad.save
    redirect_to fleets_path
  end

  def ready
    current_squad.ready!
    redirect_to fleets_path
  end

  def transfer
    @squads = Squad.all
  end

  def transfer_credits
    unless params[:transfer][:credits].empty? || params[:transfer][:squad].empty?
      @squad_destination = Squad.find(params[:transfer][:squad])
      @quantity = (params[:transfer][:credits]).to_i
      current_squad.transfer_credits @quantity, @squad_destination
    end
    redirect_to :fleets
  end


end

