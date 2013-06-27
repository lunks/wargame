require 'spec_helper'

describe Fleet do

  let(:capital_ship) {Factory :capital_ship}
  let(:light_transport) {Factory :light_transport}
  let(:trooper) {Factory :trooper}
  let(:armament) {Factory :armament}
  let(:sensor) {Factory :sensor}
  let(:commander) {Factory :commander}
  let(:fighter) {Factory :fighter}
  let(:unit) {Factory :fleet}
  let(:planet) {Factory :planet}
  let(:squad) {Factory :squad}
  let(:facility_fleet) {Factory :facility_fleet}

  context 'moving' do
    before(:each) do
      unit.squad = squad
      unit.save
      @carried_unit1 = Factory(:fleet, :carried_by => unit)
      @carried_unit2 = Factory(:fleet, :carried_by => unit)
      @moving_fleet = unit.move 1, planet
    end

    context 'setting to move' do
      it 'should be flagged as a moving unit when moving' do
        @moving_fleet.should be_moving
      end
      it 'should have a destination planet when moving' do
        @moving_fleet.destination.should == planet
      end
      it 'should flag carried units when moving' do
        @moving_fleet.should be_moving
        carried_unit1 = Fleet.find(@carried_unit1.id)
        carried_unit2 = Fleet.find(@carried_unit2.id)
        carried_unit1.should be_moving
        carried_unit2.should be_moving
      end
      it 'should flag destination on carried units when moving' do
        @moving_fleet.destination.should == planet
        carried_unit1 = Fleet.find(@carried_unit1.id)
        carried_unit2 = Fleet.find(@carried_unit2.id)
        carried_unit1.destination.should == planet
        carried_unit2.destination.should == planet
      end
    end
    
    context 'cancelling movements' do
      before(:each) do
        Fleet.destroy_all
        @planet = Factory(:planet)
        unit.planet = @planet
        unit.squad = squad
        unit.save
        @moving_fleet = unit.move 1, @planet
        @capital_ship_fleet = Factory :fleet, :generic_unit => capital_ship, :planet => @planet, :squad => squad, :quantity => 1
      end
      it 'should cancel movements when move to nil planet' do
        moving_capital_ship = @capital_ship_fleet.move 1, @planet
        moving_capital_ship.should be_moving
        Fleet.where(:moving => true).should_not be_empty 
        Fleet.last.move 1, nil
        Fleet.where(:moving => true).should be_empty 
      end
      it 'should cancel carried units movements when move to nil planet' do
        moving_capital_ship = @capital_ship_fleet.move 1, @planet
        carried_ship = Factory(:generic_fleet, :generic_unit => Factory(:fighter), :quantity => 1, :carried_by => moving_capital_ship, :moving => true, :destination => @planet)
        moving_capital_ship.should be_moving
        carried_ship.should be_moving
        Fleet.where(:moving => true).count.should == 2
        Fleet.first.move 1, nil
        Fleet.where(:moving => true).should be_empty 
      end

    end

    context 'validating movement orders' do
      before(:each) do
        @trooper_fleet = Factory :fleet, :generic_unit => trooper, :planet => planet, :squad => squad
        @armament_fleet = Factory :fleet, :generic_unit => armament, :planet => planet, :squad => squad
        @sensor_fleet = Factory :fleet, :generic_unit => sensor, :planet => planet, :squad => squad
        @commander_fleet = Factory :fleet, :generic_unit => commander, :planet => planet, :squad => squad
        @tie_fighter_fleet = Factory :fleet, :generic_unit => Factory(:generic_unit, :hyperdrive => false), :planet => planet, :squad => squad
        @planet = Factory :planet
      end

      it 'should not let troopers move without carrier ships' do
        moving_unit = @trooper_fleet.move 1, @planet
        moving_unit.should_not be_moving
      end
      it 'should not let armaments move without carrier ships' do
        moving_unit = @armament_fleet.move 1, @planet
        moving_unit.should_not be_moving
      end
      it 'should not let units without hyperdrive move without carrier ships' do
        moving_unit = @tie_fighter_fleet.move 1, @planet
        moving_unit.should_not be_moving
      end
    end

    context 'finishing movement' do
      before(:each) do
        @merging_fleet = Factory :fleet, :planet => planet, :generic_unit => unit.generic_unit, :squad => unit.squad, :fleet_name => unit.squad.name
        @moving_quantity = @moving_fleet.quantity
        @moving_fleet.move!
      end
      it 'should effect moving orders' do
        @moving_fleet.should_not be_moving
        @moving_fleet.planet.should == planet
      end
      it 'should be unflagged as a moving unit' do
        @moving_fleet.reassembly
        @moving_fleet.should_not be_moving
      end
      it 'should group fleets on the destination planet after moving has finished' do
        planet.generic_fleets.where(:generic_unit => unit.generic_unit).should have(1).fleet
        @moving_fleet.quantity.should == (@merging_fleet.quantity + @moving_quantity)
      end
    end
  end
  context 'related to fleeing fleet' do
    let(:unit) {Factory :fleet, :squad => squad}
    before(:each) do
      @origin = Factory(:planet)
      @destination = Factory(:planet)
      unit.planet = @origin
      @route1 = Factory :route, :vector_a => @origin, :vector_b => @destination
    end

    it 'should go to an adjacent planet' do
      fleeing_fleet = unit.flee! 1
      fleeing_fleet.planet.should_not == @origin
      fleeing_fleet.planet.should == @destination
    end

  end

end

