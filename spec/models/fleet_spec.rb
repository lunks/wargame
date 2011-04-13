require 'spec_helper'

describe Fleet do

  it {should belong_to :destination}
  it {should belong_to :generic_unit}

  let(:unit) {Factory :fleet}

  context 'moving' do
    let(:planet) {Factory :planet}

    it 'should be flagged as a moving unit when moving' do
      unit.move 1, planet
      Fleet.last.should be_moving
    end

    it 'should have a destination planet when moving' do
      unit.move 1, planet
      Fleet.last.destination.should == planet
    end

    it 'should effect moving orders' do
      unit.moving = true
      unit.destination = planet
      unit.move!
      unit.should_not be_moving
      unit.planet.should == planet
    end

  end
  
  context 'related to fleeing fleet' do

    it 'should go to an adjacent planet' do
      origin = Factory(:planet)
      destination = Factory(:planet)
      route = Factory :route, :vector_a => origin, :vector_b => destination
      unit.planet = origin
      unit.flee! 1
      Fleet.last.planet.should_not == origin
      Fleet.last.planet.should == destination
    end

    it 'should go first to an allied adjacent planet' do

    end

  end

end

