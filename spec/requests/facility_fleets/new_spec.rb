require 'spec_helper'

describe "facility fleets" do
  before do
    start_game
    @facility = Factory :facility
  end

  context 'when buying a new one' do
    it 'should not be listed before it is bought' do
      page.should have_no_content @facility.name
    end

    it "after bought, shows up on the main page" do
      click_link '[build facility]'
      page.should have_content Planet.first.name
      select @facility.name, :from => 'Choose a Facility:'
      click_button 'Build it'
      page.should have_content @facility.name
    end
  end
end
