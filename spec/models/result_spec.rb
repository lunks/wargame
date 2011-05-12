require 'spec_helper'

describe Result do
  it {should belong_to :generic_fleet}
  it {should belong_to :squad}
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
      @fleet.reload.first.quantity.should be 9
      #expect {result.blast!}.to change(@fleet.reload.first, :quantity).by(-1)
    end
  end
  context 'when units were captured' do
    before(:each) do
      @fleet = GenericFleet.where(:generic_unit => result.generic_unit, :planet => result.planet, :squad => result.squad)
    end
  end



end
