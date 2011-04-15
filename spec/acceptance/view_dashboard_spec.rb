require 'spec/spec_helper'

describe "Viewing dashboard" do
  before do
    setup_game!
    @planet_name =  @squad.fleets.first.planet.name
    @ship_name = @squad.fleets.first.generic_unit.name
  end
  context "viewing planets" do
    before do
      visit '/fleets'
    end

    pending 'should show the planet name' do
      page.should have_content @planet_name
    end

  end
end
