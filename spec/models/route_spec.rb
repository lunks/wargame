require 'spec_helper'

describe Route do
  it {should belong_to :vector_a}
  it {should belong_to :vector_b}
  
end
