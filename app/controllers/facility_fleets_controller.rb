class FacilityFleetsController < ApplicationController

  def index
  end

  def edit
    #TODO @units = GenericUnit.allowed_for(current_squad)
    @facility = FacilityFleet.find(params[:id])
    @units = GenericUnit.all #nao sei pq diabos ele nao mostra nada quando é da classe Unit!!!
  end

  def update
    @facility = FacilityFleet.find(params[:id])
    #TODO trazer a unidade escolhida na view
    @facility.save
    redirect_to :fleets
  end

end

