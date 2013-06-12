require 'spec_helper'

describe "Viewing dashboard" do
  before do
    start_game
    @planet_name =  @squad.fleets.first.planet.name
    @ship_name = @squad.fleets.first.generic_unit.name
    @moving_fleet = @squad.fleets.last
    destination_planet = Factory :planet
    @moving_fleet.move 1, destination_planet
  end
  after do
    Planet.enable_routes
  end

=begin

  context "viewing planets" do
    before do
      visit '/fleets'
    end

    it 'should show the planet name' do
      page.should have_content @planet_name
    end
    it 'should show fleets on a planet' do
      page.should have_content @ship_name
    end

    it 'should show moving fleets from a planet' do
      page.should have_content '-->'
    end
  end

=end


end
