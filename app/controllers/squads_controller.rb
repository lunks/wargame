class SquadsController < ApplicationController

  def new
    @squad = Squad.new
    @colors = %w[red green yellow orange]
  end

  def create
    squad = Squad.create(params[:squad])
    current_user.squad = squad
    squad.credits = 10000
    squad.save
    redirect_to root_path
  end

end

