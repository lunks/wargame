require 'spec_helper'

describe Fleet do

  it {should belong_to :destination}
  it {should belong_to :generic_unit}

  context 'moving' do
    let(:unit) {Factory :fleet}
    let(:planet) {Factory :planet}
    before(:each) do
      @moving_fleet = unit.move 1, planet
      @moving_fleet.planet = planet
    end

    context 'setting to move' do
      it 'should be flagged as a moving unit when moving' do
        @moving_fleet.should be_moving
      end

      it 'should have a destination planet when moving' do
        @moving_fleet.destination.should == planet
      end

      it 'should cancel a movement order' do
        @moving_fleet.cancel_move
        @moving_fleet.should_not be_moving
      end
    end

    context 'validating movement orders' do
      let(:capital_ship) {Factory :capital_ship}
      let(:light_transport) {Factory :light_transport}
      let(:trooper) {Factory :trooper}
      let(:armament) {Factory :armament}
      before(:each) do
        unit.planet = planet
        unit.save
        @trooper_fleet = unit
        @trooper_fleet.generic_unit = trooper
        @trooper_fleet.save
        @armament_fleet = unit
        @armament_fleet.generic_unit = armament
        @armament_fleet.save
      end

      it 'should not let troopers or armaments move without a capital ship or transport' do
        @moving_trooper = @trooper_fleet.move 1, planet
        @moving_trooper.should_not be_moving
        @moving_armament = @armament_fleet.move 1, planet
        @moving_armament.should_not be_moving
      end

      it 'should let troopers or armament move if a capital ship was moved before' do
        capital_ship_fleet = unit
        capital_ship_fleet.generic_unit = capital_ship
        @moving_capital_ship = capital_ship_fleet.move 1, planet
        @moving_trooper = @trooper_fleet.move 1, planet
        @moving_trooper.should be_moving
        @moving_armament = @armament_fleet.move 1, planet
        @moving_armament.should be_moving
      end

      it 'should let troopers or armaments move if a light transport was moved before' do
        light_transport_fleet = unit
        light_transport_fleet.generic_unit = light_transport
        @moving_light_transport = light_transport_fleet.move 1, planet
        @moving_trooper = @trooper_fleet.move 1, planet
        @moving_trooper.should be_moving
        @moving_armament = @armament_fleet.move 1, planet
        @moving_armament.should be_moving
      end

      pending 'should let armaments move if enough amount of fighters was moved before'


    end

    context 'finishing movement' do
      before(:each) do
        @merging_fleet = Factory :fleet, :planet => planet, :generic_unit => unit.generic_unit, :squad => unit.squad
        @moving_quantity = @moving_fleet.quantity
        @moving_fleet.move!
      end

      it 'should effect moving orders' do
        @moving_fleet.should_not be_moving
        @moving_fleet.planet.should == planet
      end

      it 'should group fleets on the destination planet after moving has finished' do
        planet.generic_fleets.where(:generic_unit => unit.generic_unit).should have(1).fleet
        @moving_fleet.quantity.should == (@merging_fleet.quantity + @moving_quantity)
      end
    end
  end
  context 'related to fleeing fleet' do
    let(:unit) {Factory :fleet}

    it 'should go to an adjacent planet' do
      origin = Factory(:planet)
      destination = Factory(:planet)
      route = Factory :route, :vector_a => origin, :vector_b => destination
      unit.planet = origin
      fleeing_fleet = unit.flee! 1
      fleeing_fleet.planet.should_not == origin
      fleeing_fleet.planet.should == destination
    end

    pending 'should go first to an allied adjacent planet' do

    end
  end
end

