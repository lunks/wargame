require 'spec_helper'

describe Sensor do
  it 'should be a sensor' do
    sensor = Factory :sensor
    sensor.should be_a Sensor
  end
end
