require 'spec_helper'

describe GenericUnit do
  let(:unit) {Factory :generic_unit}
  it 'should belong to a faction' do
    unit.factions = 'empire'
    unit.factions.should include 'empire'
    unit.belongs?('empire').should be_true
  end
  it 'should belong to multiple factions' do
    unit.factions = %w[empire rebel]
    unit.factions.should include 'empire'
    unit.factions.should include 'rebel'
    unit.factions.should_not include 'mercenary'
    unit.belongs?('mercenary').should be_false
  end

  it 'should calculate bitmask correctly' do
    Factory(:generic_unit, :factions => 'mercenary')
    GenericUnit.allowed_for('mercenary').should_not be_empty
  end
end

