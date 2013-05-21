module GameHelper
  def start_game
    login_user!
    @squad = Factory :squad
    @user.squad = @squad
    15.times { Factory :planet }
    Planet.disable_routes
    Factory :trooper, :factions => 'empire'
    Factory :light_transport, :factions => 'empire'
    Factory :warrior, :factions => 'empire'
    Factory :warrior, :factions => 'empire', :price => 40
    Factory :warrior, :factions => 'empire', :price => 45
    Factory :commander, :factions => 'empire'
    Factory :commander, :factions => 'empire', :price => 1000
    Factory :fighter, :factions => 'empire'
    Factory :capital_ship, :factions => 'empire'
    Factory :facility, :factions => 'empire'
    Round.getInstance.new_game!
    visit '/fleets'
  end
end
