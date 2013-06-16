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
              xml.fleet fleet.show
             end
            else
              xml.corfleet '00FFFF'            
              xml.fleet fleet.show.first(12) + '->' + fleet.destination.name
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
    xml.nome 'Painel'
    42.times { xml.available '.' }
    xml.squad_name @current_squad.name
    xml.squad_name @current_squad.color
    xml.round @round.number
    xml.phase @round_phase
    xml.squad_credits @current_squad.credits
    xml.air_income @air_income
    xml.ground_income @ground_income
    xml.flee_tax @flee_tax
    xml.provided @provided
    xml.facilities @facilities
    xml.capital_ships @capital_ships
    xml.fighters @fighters
    xml.transports @transports
    xml.sensors @sensors
    xml.commanders @commanders
    xml.warriors @warriors
    xml.troopers @troopers
    xml.comment1 @comment1
    xml.comment2 @comment2
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
