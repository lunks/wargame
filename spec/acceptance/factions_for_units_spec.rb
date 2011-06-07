require 'spec_helper'

describe "Choosing Factions for Units" do
  context 'when viewing only' do
    it 'should show unit names' do
      Factory :generic_unit, :name => 'Nave bonita'
      visit '/generic_units'
      page.should have_content('Nave bonita')
    end
  end
end
