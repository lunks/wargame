class HomeController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index]

  def index
    @rounds = Round.includes(:results)
    #redirect_to "/users/sign_in"
  end

end
