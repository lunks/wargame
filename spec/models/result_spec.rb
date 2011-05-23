require 'spec_helper'

describe Result do
  it {should belong_to :generic_fleet}
  it {should belong_to :squad}
  it {should belong_to :captor}
  it {should belong_to :planet}
  it {should belong_to :generic_unit}
  it {should belong_to :round}
  let!(:result) {Factory :result}
  context 'when units were destroyed' do
    before(:each) do
      @fleet = GenericFleet.where(:generic_unit => result.generic_unit, :planet => result.planet)
    end

    it 'all of them' do
      result.blasted = result.quantity
      result.blast!
      @fleet.should be_empty
    end
    it 'only one' do
      result.blasted = 1
      result.blast!
      @fleet.first.quantity.should be 9
    end
  end
  context 'when units fled' do
    let!(:origin) {Factory :planet}
    let!(:destination) {Factory :planet}
    before(:each) do
      @fleet = Factory :fleet, :quantity => 10, :planet => origin
      Factory :route, :vector_a => origin, :vector_b => destination
      result.generic_fleet = @fleet
      result.planet = origin
      result.fled = 1
      result.flee!
    end

    it 'quantity is decreased from the fleet' do
      @fleet.quantity.should be 9
    end

    it 'flees to a planet' do
      destination.generic_fleets.should_not be_empty
    end
  end
  context 'when units are captured' do
    let!(:captor) {Factory :squad}
    before(:each) do
      result.captor = captor
    end
  end
end
