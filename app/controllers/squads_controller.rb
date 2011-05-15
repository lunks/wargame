class SquadsController < ApplicationController

  def new
    @squad = Squad.new
    @colors = %w[FF0000 00FF00 FFFF00 914465]
  end

  def create
    squad = Squad.create(params[:squad])
    current_user.squad = squad
    squad.credits = 1000
    squad.save
    redirect_to :fleets
  end

end

