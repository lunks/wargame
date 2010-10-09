require 'spec_helper'

describe OwnedShips do
  it {should belong_to :squad}
  it {should belong_to :planet}
  it {should belong_to :ship}

end

