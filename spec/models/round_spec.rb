require 'spec_helper'

describe Round do
  before(:each) do
    Round.create!{[:number => 1]} if Round.last.nil?
  end
  let (:round) {Round.getInstance}
  let! (:rebel) {Factory :squad}
  let! (:empire) {Factory :squad}

  context 'beginning a new round' do
    before(:each) do
      empire.destroy # stinking empire!
      rebel.planets.clear
      rebel.facility_fleets.clear
      Factory :fighter, :price => 100
      Factory :facility
      Factory :capital_ship, :price => 500
      Factory :trooper, :price => 2
      5.times {Factory.create :planet}
      round.new_game!
    end

    it 'should get a random planet for the squad' do
      rebel.planets(true).should_not be_empty
    end
    it 'should place a facility on the new planet' do
      rebel.facility_fleets(true).should_not be_empty
    end
    it 'should place random units on the planets' do
      rebel.generic_fleets.count.should == 30
    end
  end

  context 'rounds logic' do
  end

end

