require 'spec_helper'

describe Squad do
  it {should have_many :planets}
  it {should have_and_belong_to_many :ships }
end

