require 'spec_helper'

describe Trooper do
  it 'should be a trooper' do
    trooper = Factory :trooper
    trooper.should be_a Trooper
  end
end
