require 'spec_helper'

describe CapitalShip do
  it 'should be a capital ship' do
    capital_ship = Factory :capital_ship
    capital_ship.should be_a CapitalShip
  end
end
