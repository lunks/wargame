xml.instruct!
xml.planetas do
  @planets.each do |planet|
    counter = 0
    xml.planeta do
      xml.nome planet.name.gsub(" ","")
      if planet.squad
        xml.espaco planet.description
        xml.corespaco planet.squad.color
      else
        xml.espaco planet.description
        xml.corespaco ' '
      end
      if planet.ground_squad
        xml.terra planet.description
        xml.corterra planet.ground_squad.color
      else
        xml.terra planet.description
        xml.corterra ' '
      end
      has_fleet = planet.generic_fleets.select { |ships| ships.squad == @current_squad }
      if !has_fleet.empty?
        planet.generic_fleets.where(:squad_id => @current_squad).each_with_index do |fleet, index|
          xml.corfleet fleet.squad.color
          if !fleet.moving
            if fleet.type?(Facility) or fleet.type?(Warrior) or fleet.type?(Commander)
              xml.fleet fleet.generic_unit.name
            elsif fleet.type?(Facility)
              xml.fleet fleet.generic_unit.description
            else
              xml.fleet fleet.quantity.to_s + ' ' + fleet.generic_unit.name
            end
          else
            xml.fleet fleet.generic_unit.name + '-->' + fleet.destination.name
          end
          counter +=1
        end
        if counter < 8
          (8 - counter).times do
            xml.corfleet '.'
            xml.fleet '.'
          end
        end  
      else
         8.times do
           xml.corfleet '.'
           xml.fleet '.'
         end
      end

    end
  end
end
