require 'spec_helper'

describe Tradeport do
  it {should belong_to :planet}
  it {should belong_to :generic_unit}

  let(:tradeport) {Factory :tradeport}

  context 'acting like a trade station' do
    before do
      3.times {Factory.create :planet}
      3.times {Factory.create :capital_ship}
      3.times {Factory.create :armament}
      Tradeport.produce_units
    end

    it 'should has a negotiation rate' do
      Tradeport.first.negotiation_rate.should_not be_nil
    end

    it 'should have units on stock' do
      Tradeport.count.should be 3
    end

    it 'should show negotiation rate' do
      Tradeport.first.show_negotiation_rate
    end

  end


  context 'buying units' do
    before do
      @squad = Factory(:squad, :credits => 1000)
      unit = Factory(:generic_unit, :price => 500)
      planet = Factory(:planet)
      @fleet = Factory(:generic_fleet, :planet => planet, :squad => @squad, :generic_unit => unit, :quantity => 1)    
      Tradeport.buy_unit planet, @fleet, 1
    end

    it 'should remove unit from squad fleet' do
      @squad.generic_fleets.count.should be 0
    end

    it 'should add unit to stock' do
      Tradeport.all.count.should be 1
    end

    it 'should pay credits to squad' do
      @squad.credits.should == 1000 + @fleet.generic_unit.price * 0.50
    end

  end

  context 'selling units' do
    before do
      @squad = Factory(:squad, :credits => 1000)
      unit = Factory(:generic_unit, :price => 500)
      @unit = Factory(:tradeport, :generic_unit => unit, :negotiation_rate => 50)
      @unit.sell_unit @squad, 1
    end

    it 'should add unit to squad fleet' do
      @squad.generic_fleets.count.should be 1
    end

    it 'should remove unit from stock' do
      Tradeport.all.count.should be 0
    end

    it 'should debit credits from squad' do
      @squad.credits.should == (@squad.credits - @unit.generic_unit.price * (@unit.negotiation_rate / 100)).to_i
    end

  end
 
end
