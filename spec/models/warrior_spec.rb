require 'spec_helper'

describe Warrior do
  it 'should be a warrior' do
    warrior = Factory :warrior
    warrior.should be_a Warrior
  end
end
