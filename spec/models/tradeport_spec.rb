require 'spec_helper'

describe Tradeport do
  it {should belong_to :planet}
  it {should belong_to :generic_unit}

  let(:tradeport) {Factory :tradeport}

  context 'acting like a trade station' do
    before do
      3.times {Factory.create :planet}
      tradeport.create_units
    end

    it 'should have units on stock' do
      #tradeport.should_not be_empty
    end


  end


  context 'buying units' do
    before(:each) do
      
    end

    it 'should has a negotiation rate' do
    end

    it 'should add units to stock' do
      
    
    end

  end
 
end
