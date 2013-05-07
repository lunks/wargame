require 'spec_helper'

describe Fighter do
  it 'should be a fighter' do
    fighter = Factory :fighter
    fighter.should be_a Fighter
  end
end
