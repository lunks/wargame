class Fighter < Unit
  scope :fighter, where(:price => 60...400)
end

