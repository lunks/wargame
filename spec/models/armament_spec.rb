require 'spec_helper'

describe Armament do
  it 'should be an armament' do
    armament = Factory :armament
    armament.should be_a Armament
  end
end
