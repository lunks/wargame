require 'spec_helper'

describe Planet do
  it {should belong_to :squad}
  it {should have_many :owned_ships}
end

