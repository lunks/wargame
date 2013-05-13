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
      @squad = squad
      @planet = planet
      unit.squad = @squad
      unit.save
      @moving_fleet = unit.move 1, @planet
    end

    context 'setting to move' do
      it 'should be flagged as a moving unit when moving' do
        @moving_fleet.should be_moving
      end
      it 'should have a destination planet when moving' do
        @moving_fleet.destination.should == planet
      end
    end
    
    context 'cancelling movements' do
      before(:each) do
        Fleet.destroy_all
        unit.planet = planet
        unit.squad = squad
        unit.save
        @moving_fleet = unit.move 1, planet
        @capital_ship_fleet = Factory :fleet, :generic_unit => capital_ship, :planet => planet, :squad => squad
      end
      it 'should cancel movements when move to nil planet' do
        moving_capital_ship = @capital_ship_fleet.move 1, planet
        moving_capital_ship.should be_moving
        Fleet.where(:moving => true).should_not be_empty 
        Fleet.last.move 1, nil
        Fleet.where(:moving => true).should be_empty 
      end
      it 'should cancel movements to a planet when change one' do
        moving_capital_ship = @capital_ship_fleet.move 1, planet
        moving_capital_ship.should be_moving
        Fleet.where(:moving => true).count.should == 2
        Fleet.last.move 1, planet
        Fleet.where(:moving => true).count.should == 1
      end
    end

    context 'validating movement orders' do
      before(:each) do
        @trooper_fleet = Factory :fleet, :generic_unit => trooper, :planet => @planet, :squad => @squad
        @armament_fleet = Factory :fleet, :generic_unit => armament, :planet => @planet, :squad => @squad
        @sensor_fleet = Factory :fleet, :generic_unit => sensor, :planet => @planet, :squad => @squad
        @commander_fleet = Factory :fleet, :generic_unit => commander, :planet => @planet, :squad => @squad 
      end

      it 'should not let troopers move without a capital ship or transport' do
        moving_trooper = @trooper_fleet.move 1, planet
        moving_trooper.should_not be_moving
      end
      it 'should not let armaments move without a capital ship or transport' do
        moving_armament = @armament_fleet.move 1, planet
        moving_armament.should_not be_moving
      end
      it 'should not let sensors move without a capital ship or transport' do
        moving_sensor = @sensor_fleet.move 1, planet
        moving_sensor.should_not be_moving
      end
      it 'should not let commanders move without a capital ship, transport or fighter' do
        moving_commander = @commander_fleet.move 1, planet
        moving_commander.should_not be_moving
      end
      
      context 'moving with capital ships' do
        before(:each) do
          capital_ship_fleet = Factory :fleet, :generic_unit => capital_ship, :planet => @planet, :squad => @squad
          @moving_capital_ship = capital_ship_fleet.move 1, planet
        end
        it 'should let troopers move' do
          moving_trooper = @trooper_fleet.move 1, planet
          moving_trooper.should be_moving
        end
        it 'should let armaments move' do
          moving_armament = @armament_fleet.move 1, planet
          moving_armament.should be_moving
        end
        it 'should let commanders move' do
          moving_commander = @commander_fleet.move 1, planet
          moving_commander.should be_moving
        end
        it 'should let sensors move' do
          moving_sensor = @sensor_fleet.move 1, planet
          moving_sensor.should be_moving
        end
      end

      context 'moving with light transports' do
        before(:each) do
          light_transport_fleet = Factory :fleet, :generic_unit => light_transport, :planet => @planet, :squad => @squad
          @moving_light_transport = light_transport_fleet.move 1, planet
        end
        it 'should let troopers move' do
          moving_trooper = @trooper_fleet.move 1, planet
          moving_trooper.should be_moving
        end
        it 'should let armaments move' do
          moving_armament = @armament_fleet.move 1, planet
          moving_armament.should be_moving
        end
        it 'should let commanders move' do
          moving_commander = @commander_fleet.move 1, planet
          moving_commander.should be_moving
        end
        it 'should let sensors move' do
          moving_sensor = @sensor_fleet.move 1, planet
          moving_sensor.should be_moving
        end
      end

      it 'should let troopers, armaments and commanders move with enough amount of fighters' do
        Fleet.destroy_all
        @commander_fleet = Factory :fleet, :generic_unit => commander, :planet => @planet, :squad => @squad
        @armament_fleet = Factory :fleet, :generic_unit => armament, :planet => @planet, :squad => @squad
        @fighter_fleet = Factory :fleet, :generic_unit => fighter, :planet => @planet, :squad => @squad
        moving_fighter = @fighter_fleet.move 5, planet
        moving_fighter.save
        moving_armament = @armament_fleet.move 5, planet      
        moving_armament.should be_moving
        moving_commander = @commander_fleet.move 5, planet      
        moving_commander.should be_moving
      end

      it 'should prevent no hyperdrive fighters move without a capital ship' do
        tie_fighter = fighter
        tie_fighter.hyperdrive = false
        tie_fighter.save
        @fighter_fleet = Factory :fleet, :generic_unit => tie_fighter, :planet => @planet, :squad => @squad
        moving_fighter = @fighter_fleet.move 1, planet
        moving_fighter.should_not be_moving
        @capital_ship_fleet = Factory :fleet, :generic_unit => capital_ship, :planet => @planet, :squad => @squad
        moving_capital_ship = @capital_ship_fleet.move 1, planet
        moving_fighter = @fighter_fleet.move 1, planet
        moving_fighter.should be_moving
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

    it 'should go first to an allied adjacent planet' do
      @allied_destination = Factory(:planet)
      @allied_destination.squad = squad
      @allied_destination.save
      @route2 = Factory :route, :vector_a => @origin, :vector_b => @allied_destination
      fleeing_fleet = unit.flee! 1
      fleeing_fleet.planet.should == @allied_destination
    end

    it 'should go second to an neutral adjacent planet' do
      @enemy_destination = Factory(:planet)
      @enemy_destination.squad = Factory(:squad)
      @enemy_destination.save
      @route2 = Factory :route, :vector_a => @origin, :vector_b => @enemy_destination
      fleeing_fleet = unit.flee! 1
      fleeing_fleet.planet.should_not == @enemy_destination
    end

    it 'should go last to an enemy planet' do
      @enemy_destination = Factory(:planet)
      @enemy_destination.squad = Factory(:squad)
      @enemy_destination.save
      @route2 = Factory :route, :vector_a => @origin, :vector_b => @enemy_destination
      fleeing_fleet = unit.flee! 1
      fleeing_fleet.planet.should == @destination
      fleeing_fleet.planet.should_not == @enemy_destination    
    end
  end

end

