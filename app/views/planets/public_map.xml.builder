xml.instruct!
xml.planetas do
  @planets.each do |planet|
    xml.planeta do
      xml.nome planet.name.gsub(" ","")
      if planet.squad
        xml.espaco planet.squad.name
        xml.corespaco planet.squad.color
      else
        xml.espaco 'Neutral'
        xml.corespaco ' '
      end
      if planet.ground_squad
        xml.terra planet.ground_squad.name
        xml.corterra planet.ground_squad.color
      else
        xml.terra 'Neutral'
        xml.corterra ' '
      end
      8.times do
        xml.corfleet '.'
        xml.fleet '.'
      end
    end
  end
end
