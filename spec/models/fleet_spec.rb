require 'spec_helper'

describe Fleet do

  it {should belong_to :destination}
  it {should belong_to :generic_unit}

  let(:capital_ship) {Factory :capital_ship}
  let(:light_transport) {Factory :light_transport}
  let(:trooper) {Factory :trooper}
  let(:armament) {Factory :armament}
  let(:fighter) {Factory :fighter}
  let(:unit) {Factory :fleet}
  let(:planet) {Factory :planet}
  let(:squad) {Factory :squad}

  context 'moving' do
    before(:each) do
      @moving_fleet = unit.move 1, planet
      @planet = planet
      @squad = squad
    end

    context 'setting to move' do
      it 'should be flagged as a moving unit when moving' do
        @moving_fleet.should be_moving
      end

      it 'should have a destination planet when moving' do
        @moving_fleet.destination.should == planet
      end

    end

    context 'validating movement orders' do
      before(:each) do
        @trooper_fleet = Factory :fleet, :generic_unit => trooper, :planet => @planet, :squad => @squad
        @armament_fleet = Factory :fleet, :generic_unit => armament, :planet => @planet, :squad => @squad
      end

      it 'should not let troopers or armaments move without a capital ship or transport' do
        moving_trooper = @trooper_fleet.move 1, planet
        moving_trooper.should_not be_moving
        moving_armament = @armament_fleet.move 1, planet
        moving_armament.should_not be_moving
      end

      it 'should let troopers or armament move if a capital ship was moved before' do
        capital_ship_fleet = Factory :fleet, :generic_unit => capital_ship, :planet => @planet, :squad => @squad
        moving_capital_ship = capital_ship_fleet.move 1, planet
        moving_trooper = @trooper_fleet.move 1, planet
        moving_trooper.should be_moving
        moving_armament = @armament_fleet.move 1, planet
        moving_armament.should be_moving
      end

      it 'should let troopers or armaments move if a light transport was moved before' do
        light_transport_fleet = Factory :fleet, :generic_unit => light_transport, :planet => @planet, :squad => @squad
        moving_light_transport = light_transport_fleet.move 1, planet
        moving_trooper = @trooper_fleet.move 1, planet
        moving_trooper.should be_moving
        moving_armament = @armament_fleet.move 1, planet
        moving_armament.should be_moving
      end

      it 'should let troopers or armaments move if enough amount of fighters was moved before' do
        Fleet.destroy_all
        @armament_fleet = Factory :fleet, :generic_unit => armament, :planet => @planet, :squad => @squad
        fighter_fleet = Factory :fleet, :generic_unit => fighter, :planet => @planet, :squad => @squad
        moving_fighter = fighter_fleet.move 5, planet
        moving_fighter.save
        moving_armament = @armament_fleet.move 5, planet      
        moving_armament.should be_moving
      end

      it 'should not let units with no hyperdrive to move without a capital ship' do
 
      end


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
    before(:each) do
      @origin = Factory(:planet)
      @destination = Factory(:planet)
      @allied_destination = Factory(:planet)
      @allied_destination.squad = squad
      @allied_destination.save
      @route1 = Factory :route, :vector_a => @origin, :vector_b => @destination
      @route2 = Factory :route, :vector_a => @origin, :vector_b => @allied_destination
    end

    it 'should go to an adjacent planet' do
      unit.planet = @origin
      fleeing_fleet = unit.flee! 1
      fleeing_fleet.planet.should_not == @origin
      fleeing_fleet.planet.should == @destination
    end

    pending 'should go first to an allied adjacent planet' do

    end
  end
end

