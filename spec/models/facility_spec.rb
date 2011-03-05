require 'spec_helper'

describe Facility do
  let(:facility) {Factory :facility}

  it 'should be a facility' do
    facility.should be_an_instance_of Facility
    facility.should be_a_kind_of GenericUnit
  end
 
end

