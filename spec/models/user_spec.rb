require 'spec_helper'

describe User do
  it {should have_one :squad}
end

