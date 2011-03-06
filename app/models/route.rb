class Route < ActiveRecord::Base
  belongs_to :vector_a, :class_name => "Planet", :foreign_key => 'vector_a'
  belongs_to :vector_b, :class_name => "Planet", :foreign_key => 'vector_b'
end
