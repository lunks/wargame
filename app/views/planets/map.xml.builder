xml.instruct!
if @current_squad
xml.planetas do
  @planets.each do |planet|
    counter = 0
    xml.planeta do
      xml.nome planet.name.gsub(" ","")
      xml.planet_id planet.id
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
      xml.available ' '
      has_fleet = planet.generic_fleets.select { |fleet| fleet.squad == @current_squad }
      unless has_fleet.empty?
        planet.generic_fleets.each_with_index do |fleet, index|       
            
            unless fleet.moving && fleet.squad == @current_squad
             if @round.move && fleet.squad != @current_squad
               xml.corfleet fleet.squad.color
               xml.fleet fleet.squad.name
             else
              xml.corfleet fleet.squad.color
              
              if fleet.type?(Facility) or fleet.type?(Warrior) or fleet.type?(Commander) or fleet.type?(Sensor)
                xml.fleet fleet.name
              else
                xml.fleet fleet.quantity.to_s + ' ' + fleet.generic_unit.name
              end
             end

            else
              xml.corfleet '00FFFF'
             
              if fleet.type?(Facility) or fleet.type?(Warrior) or fleet.type?(Commander) or fleet.type?(Sensor)
                xml.fleet fleet.name.first(12) + '->' + fleet.destination.name
              else
                xml.fleet fleet.quantity.to_s + ' ' + fleet.name.first(12) + '->' + fleet.destination.name
              end

            end

            counter +=1
        end

        if counter < 18

          (18 - counter).times do
            xml.corfleet '.'
            xml.fleet '.'
          end

        end  

      else
        
         18.times do
           xml.corfleet '.'
           xml.fleet '.'
         end

      end

    end
  end

  xml.planeta do
    xml.nome 'controlpanel'
    xml.squad_name
    xml.round
    xml.phase
    xml.squad_credits
    xml.air_income
    xml.ground_income
    xml.flee_tax
    xml.provided
    xml.facilities
    xml.capital_ships
    xml.fighters
    xml.transports
    xml.sensors
    xml.commanders
    xml.warriors
    xml.troopers
  end

end

else 

xml.planetas do
  @planets.each do |planet|
    xml.planeta do
      xml.nome planet.name.gsub(" ","")
      xml.planet_id ' '
      if planet.squad
        xml.espaco planet.squad.name
        xml.corespaco planet.squad.color
      else
        xml.espaco 'Neutral'
        xml.corespaco ' '
      end
      xml.available ' '
      if planet.ground_squad
        xml.terra planet.ground_squad.name
        xml.corterra planet.ground_squad.color
      else
        xml.terra 'Neutral'
        xml.corterra ' '
      end
      18.times do
        xml.corfleet '.'
        xml.fleet '.'
      end
    end
  end
end


end
