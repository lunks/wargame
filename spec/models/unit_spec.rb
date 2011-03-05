require 'spec_helper'

describe Unit do

  let(:unit) {Factory :unit}

  it 'should be a unit' do
    unit.should be_an_instance_of Unit
    unit.should be_a_kind_of GenericUnit
  end



end

