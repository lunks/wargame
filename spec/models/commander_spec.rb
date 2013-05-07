require 'spec_helper'

describe Commander do
  it 'should be a commander' do
    commander = Factory :commander
    commander.should be_a Commander
  end
end
