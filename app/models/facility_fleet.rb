class FacilityFleet < GenericFleet
  belongs_to :producing_unit, :class_name => "Unit"
end
