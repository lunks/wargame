require 'spec_helper'

describe Fleet do

  it {should belong_to :destination}
  it {should belong_to :generic_unit}

  let(:unit) {Factory :fleet}

  context 'moving and attacking' do
    let(:planet) {Factory :planet}
    it 'should be flagged as a moving unit when moving' do
      unit.move 1, planet
      unit.should be_moving
    end

    it 'should have a destination planet when moving' do
      unit.move 1, planet
      unit.destination.should == planet
    end
  end
  context 'related to fleeing fleet' do

    it 'should go to an adjacent planet' do
      planet_origin = Factory(:planet)
      planet_destiny = Factory(:planet)
      route = Factory(:route)
      route.vector_a = planet_origin
      route.vector_b = planet_destiny
      route.save!
      unit.planet = planet_origin
      unit.save!
      current_planet = unit.planet
      unit.flee! 1
      #unit.squad.generic_fleets.first.planet.should == current_planet
      Fleet.last.planet.should_not == current_planet
      Fleet.last.planet.should == planet_destiny
    end

    it 'should go first to an allied adjacent planet' do

    end

  end

end

