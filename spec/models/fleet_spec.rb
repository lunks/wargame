require 'spec_helper'

describe Fleet do

  it {should belong_to :destination}
  it {should belong_to :generic_unit}

  let(:unit) {Factory :fleet}

  context 'moving' do
    let(:planet) {Factory :planet}
    before(:each) do
      @moving_fleet = unit.move 1, planet
    end

    context 'setting to move' do

      it 'should be flagged as a moving unit when moving' do
        @moving_fleet.should be_moving
      end

      it 'should have a destination planet when moving' do
        @moving_fleet.destination.should == planet
      end

    end
    context 'finishing movement' do
      before(:each) do
        @merging_fleet = Factory :fleet, :planet => planet, :generic_unit => unit.generic_unit
        @moving_fleet.move!
      end

      it 'should effect moving orders' do
        @moving_fleet.should_not be_moving
        @moving_fleet.planet.should == planet
      end

      it 'should group fleets on the destination planet after moving has finished' do
        planet.generic_fleets.where(:generic_unit => unit.generic_unit).should have(1).fleet
        @merging_fleet.quantity.should == (@merging_fleet.quantity + @moving_fleet.quantity)
      end
    end
  end
  context 'related to fleeing fleet' do

    it 'should go to an adjacent planet' do
      origin = Factory(:planet)
      destination = Factory(:planet)
      route = Factory :route, :vector_a => origin, :vector_b => destination
      unit.planet = origin
      fleeing_fleet = unit.flee! 1
      fleeing_fleet.planet.should_not == origin
      fleeing_fleet.planet.should == destination
    end

    it 'should go first to an allied adjacent planet' do

    end
  end
end

