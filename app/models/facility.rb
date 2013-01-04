class Facility < GenericUnit
 
  def capacity
    self.price / 3
  end

  def capacity_upgraded
    (self.price / 3) * 1.20
  end

end

