module GameHelper
  def start_game
    login_user!
    @squad = Factory :squad
    @user.squad = @squad
    5.times { Factory :planet }
    Planet.disable_routes
    Factory :trooper, :factions => 'empire'
    Factory :fighter, :factions => 'empire'
    Factory :capital_ship, :factions => 'empire'
    Factory :facility, :factions => 'empire'
    Round.getInstance.new_game!
    visit '/fleets'
  end
end
