require 'spec_helper'

describe Round do
    
  it {should have_many :results}

  rebel = Factory :squad
  empire = Factory :squad
  4.times { Factory :goal }

  context 'beginning a new round' do
    before do
      #empire.destroy # stinking empire!
      @round = Round.getInstance
      rebel.planets.clear
      rebel.facility_fleets.clear
      Factory :fighter, :price => 100
      Factory :facility
      Factory :light_transport, :price => 100
      Factory :warrior, :price => 50
      Factory :warrior, :price => 40
      Factory :commander, :price => 800
      Factory :commander, :price => 1000
      Factory :capital_ship, :price => 500
      Factory :trooper, :price => 2
      15.times {Factory.create :planet, :credits => 100}
      @round.new_game!
    end

    it 'should get a random planet for the squad' do
      rebel.planets(true).should_not be_empty
    end
    it 'should create 3 wormholes' do
      wormholes = Planet.where(:wormhole => true).all
      wormholes.count.should == 6
    end
    it 'should place a facility on the new planet' do
      rebel.facility_fleets(true).should_not be_empty
    end
    it 'should place random units on the planets' do
      rebel.generic_fleets.count.should == 28
    end

    it 'should set squad ready' do
      rebel.ready!
      rebel.ready.should be_true
    end

    it 'should change phases when all squads ready' do
      #simula o @round.end_moving!
      Squad.where(:id => rebel.id).first.ready!
      Squad.where(:id => empire.id).first.ready!
      Round.getInstance.attack.should be_true
      Squad.where(:id => rebel.id).first.ready.should be_nil
      #simula o @round.end_round!
      Squad.where(:id => rebel.id).first.ready!
      Squad.where(:id => empire.id).first.ready!
      Round.getInstance.number.should == 2
      Round.getInstance.move.should be_true
    end
 
    it 'should unflag sabotaged facilities when passing moving phase' do
      test_facility = FacilityFleet.first
      test_facility.sabotage!
      test_facility.sabotaged.should be_true
      rebel.ready!
      empire.ready!
      @round.end_moving!
      FacilityFleet.where(:sabotaged => true).count.should == 0
    end
    it 'should unflag sabotaged sensor when passing moving phase' do
      #TODO
    end

    it 'should not reassembly facility in enemy planet' do
      facility_fleet = FacilityFleet.where(:squad => Squad.last).first
      facility_fleet.moving = true
      facility_fleet.planet = Planet.where(:squad => Squad.first).first
      facility_fleet.save
      @round.end_round!
      facility_fleet.moving.should be_true
      facility_fleet = FacilityFleet.where(:squad => Squad.last).first
      facility_fleet.planet = Planet.where(:squad => Squad.last).first
      facility_fleet.save
      @round.end_round!
      facility_fleet.moving.should_not be_true
    end
    it 'should not reassembly sensor in enemy planet' do
      #TODO
    end

  end
end

