class HomeController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index]

  def index
    @rounds = Round.includes(:results)
  end


end
