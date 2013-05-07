require 'spec_helper'

describe LightTransport do
  it 'should be a light transport' do
    light_transport = Factory :light_transport
    light_transport.should be_a LightTransport
  end
end
