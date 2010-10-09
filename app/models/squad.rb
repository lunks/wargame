class Squad < ActiveRecord::Base
  has_many :planets
  has_and_belongs_to_many :ships
end

