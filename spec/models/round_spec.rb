require 'spec_helper'

describe Round do
    
  rebel = Factory :squad
  empire = Factory :squad

  context 'beginning a new round' do
    before(:each) do
      #empire.destroy # stinking empire!
      @round = Round.getInstance
      rebel.planets.clear
      rebel.facility_fleets.clear
      Factory :fighter, :price => 100
      Factory :facility
      Factory :light_transport, :price => 100
      Factory :warrior, :price => 50
      Factory :warrior, :price => 40
      Factory :capital_ship, :price => 500
      Factory :trooper, :price => 2
      15.times {Factory.create :planet, :credits => 100}
      @round.new_game!
    end

    it 'should get a random planet for the squad' do
      rebel.planets(true).should_not be_empty
    end
    it 'should create 2 wormholes' do
      wormholes = Planet.where(:wormhole => true).all
      wormholes.count.should == 4
    end
    it 'should place a facility on the new planet' do
      rebel.facility_fleets(true).should_not be_empty
    end
    it 'should place random units on the planets' do
      rebel.generic_fleets.count.should == 23
    end

    it 'should set squad ready' do
      rebel.ready!
      rebel.ready.should be_true
    end
    it 'should go to attack phase when all squads ready' do
#TODO o teste está meia boca pois ao dar ready! deveria checar e rodar o end_moving e end_round...
      rebel.ready!
      empire.ready!
      @round.end_moving!
      rebel.ready!
      empire.ready!
      @round.end_round!
      Round.getInstance.number.should == 2
      Round.getInstance.move.should be_true
    end
    it 'should reset state of squads' do
    end
  end
end

