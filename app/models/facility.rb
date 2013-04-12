class Facility < GenericUnit
 
  def capacity
    (self.price / 3).to_i
  end

end

