xml.instruct!
xml.planetas do
  @planets.each do |planet|
    counter = 0
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
      has_fleet = planet.generic_fleets.select { |ships| ships.squad == @current_squad }
      if !has_fleet.empty?
        planet.generic_fleets.where(:squad_id => @current_squad).sort_by{|a| [a.generic_unit.type, a.quantity, a.generic_unit.name]}.each_with_index do |fleet, index|
          xml.corfleet fleet.squad.color
          if !fleet.moving
            xml.fleet fleet.quantity.to_s + ' ' + fleet.generic_unit.name 
          elsif fleet.type?(Facility)
            xml.fleet fleet.generic_unit.description
          else
            xml.fleet '.'
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
