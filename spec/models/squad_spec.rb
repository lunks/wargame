require 'spec_helper'

describe Squad do
  let(:squad) {Factory :squad}
  it {should have_many :planets}
  it {should have_and_belong_to_many :ships }
  context 'buying and selling ships' do
    before(:each) do
      @ship = Factory :ship
      squad.ships << @ship
    end
    it 'should be able to buy ships and remove credits accordingly' do
      squad.credits = 1000
      @ship.price = 1000
     # squad.ships.push ship
      squad.buy @ship
      squad.credits.should be_zero
    end

    it 'should not be able to buy a ship they dont have access to' do
      squad.ships.clear
      squad.buy(@ship).should be_false
    end

    it 'should be able to buy a ship they have access to' do
      #squad.ships << ship
      squad.buy(@ship).should be_true
    end
  end

end

