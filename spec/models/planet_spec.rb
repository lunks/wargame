require 'spec_helper'

describe Planet do
  let(:planet) {Factory :planet}

  it {should belong_to :squad}
  it {should have_many :generic_fleets}
  it {should have_many :results}
  it {should belong_to :ground_squad}
  it {should belong_to :first_player}
  it {should belong_to :last_player}

  context '.seen_by squad' do
    before do
      @squad = Factory :squad
      @fleet = Factory :generic_fleet, :planet => planet, :squad => @squad
    end
    it 'should find planets where planet has squads on it' do
      Planet.seen_by(@squad).should include planet
    end
    it 'should not include a planet squad doesnt have any ships' do
      not_seen = Factory :planet
      Planet.seen_by(@squad).should_not include not_seen
    end
    it 'should not bring more than one instance of the planet' do
      Factory :generic_fleet, :planet => planet, :squad => @squad
      planets = Planet.seen_by(@squad)
      planets.should == planets.uniq
    end
  end

  it 'should output its full profits if the squad has air and ground ownership and doesnt have an enemy on planet' do
    planet.credits = 1000
    planet.credits_per_turn.should be 0

    squad = Factory :squad
    facility = Factory :generic_fleet, :squad => squad, :generic_unit => Factory(:facility)
    trooper = Factory :generic_fleet, :squad => squad, :generic_unit => Factory(:trooper)
    enemy_unit = Factory :generic_fleet, :squad => Factory(:squad), :generic_unit => Factory(:unit)

    planet.generic_fleets << facility
    planet.generic_fleets << trooper
    planet.set_ownership
    planet.set_ground_ownership
    planet.credits_per_turn.should be 1000

    planet.generic_fleets << enemy_unit
    planet.set_ownership
    planet.set_ground_ownership
    planet.credits_per_turn.should be 0
  end

  it 'should output 50% profits if the squad has air ownership and doesnt have an enemy on planet' do
    planet.credits = 1000
    planet.credits_per_turn.should be 0

    squad = Factory :squad
    facility = Factory :generic_fleet, :squad => squad, :generic_unit => Factory(:facility)
    enemy_trooper = Factory :generic_fleet, :squad => Factory(:squad), :generic_unit => Factory(:trooper)
    
    planet.generic_fleets << facility
    planet.set_ownership
    planet.set_ground_ownership
    planet.credits_per_turn.should be 500
   
    planet.generic_fleets << enemy_trooper
    planet.set_ownership
    planet.set_ground_ownership
    planet.credits_per_turn.should be 0
  end

  it 'should output 50% profits if the squad has ground ownership and doesnt have an enemy on planet' do
    planet.credits = 1000
    planet.credits_per_turn.should be 0

    squad = Factory :squad
    trooper = Factory :generic_fleet, :squad => squad, :generic_unit => Factory(:trooper)
    enemy_unit = Factory :generic_fleet, :squad => Factory(:squad), :generic_unit => Factory(:unit)
    
    planet.generic_fleets << trooper
    planet.set_ownership
    planet.set_ground_ownership
    planet.credits_per_turn.should be 500
   
    planet.generic_fleets << enemy_unit
    planet.set_ownership
    planet.set_ground_ownership
    planet.credits_per_turn.should be 0
  end

  context 'regarding partial and full ownerships' do
    before(:each) do
      @squad = Factory :squad
      planet.squad = @squad
    end
    it 'should remove its ownership if it doesnt have a facility on it' do
      planet.set_ownership
      planet.squad.should be_nil
    end
    it 'should remove its ground ownership if it doesnt have a trooper on it' do
      planet.set_ground_ownership
      planet.ground_squad.should be_nil
    end
    context 'air ownership' do
      let(:facility) {Factory :generic_fleet, :squad => @squad, :generic_unit => Factory(:facility)}

      it 'should change its ownership if it has a facility on it' do
        planet.generic_fleets << facility
        planet.set_ownership
        planet.squad.should be @squad
      end
    end

    context 'ground ownership' do
      let(:trooper) {Factory :generic_fleet, :squad => @squad, :generic_unit => Factory(:trooper)}

      it 'should change its owner if planet has a trooper on it' do
        other_trooper = Factory :generic_fleet, :squad => Factory(:squad)
        planet.generic_fleets << other_trooper
        planet.generic_fleets << trooper
        planet.set_ground_ownership
        planet.ground_squad.should be @squad
      end
    end
  end

  it 'should get a random planet' do
    3.times {Factory :planet}
    Planet.randomize.should be_an_instance_of Planet
  end
  it 'should find planets adjacent of it' do
    second_planet = Factory :planet
    Factory :route, :vector_a => planet, :vector_b => second_planet
    planet.routes.should include(second_planet)
  end


  it 'should have a disable switch for routes' do
    2.times {Factory :planet}
    Planet.disable_routes
    planet.routes.should == Planet.all
    Planet.enable_routes
  end

  it 'should verify if there is a conflict on planet' do
    2.times {Factory :generic_fleet, :planet => planet}
    planet.should be_under_attack
  end

  it 'should verify if a squad can construct on planet' do
    squad = Factory :squad
    trooper = Factory :generic_fleet, :squad => squad, :generic_unit => Factory(:trooper)
    capital_ship = Factory :generic_fleet, :squad => squad, :generic_unit => Factory(:capital_ship)
    planet.generic_fleets << capital_ship
    planet.able_to_construct?(squad).should_not be_true
    planet.generic_fleets << trooper
    planet.able_to_construct?(squad).should be_true
  end

  it 'should verify if planet has a specific enemy type' do
    squad = Factory :squad
    trooper = Factory :generic_fleet, :generic_unit => Factory(:trooper)
    capital_ship = Factory :generic_fleet, :generic_unit => Factory(:capital_ship)
    planet.generic_fleets << capital_ship
    planet.generic_fleets << trooper
    planet.has_an_enemy?(Fighter, squad).should be_false
    planet.has_an_enemy?(CapitalShip, squad).should be_true
    planet.has_an_enemy?(Trooper, squad).should be_true
  end

  context 'selecting the best route for a fleeing fleet' do
    before(:each) do
      @squad = Factory :squad
      @enemy_squad = Factory :squad
      @unit = Factory :fleet, :squad => @squad
      @allied_unit = Factory :fleet, :squad => @squad
      @enemy_unit = Factory :fleet, :squad => @enemy_squad
      @destination1 = Factory(:planet)
      @destination2 = Factory(:planet)
      @destination3 = Factory(:planet)
      @destination1.generic_fleets.destroy_all
      @destination2.generic_fleets.destroy_all
      @destination3.generic_fleets.destroy_all
      planet.generic_fleets.destroy_all
      Route.destroy_all
      planet.generic_fleets << @unit
      route1 = Factory :route, :vector_a => planet, :vector_b => @destination1
      route2 = Factory :route, :vector_a => planet, :vector_b => @destination2
      route3 = Factory :route, :vector_a => planet, :vector_b => @destination3
    end

    it 'should go first to an allied only planet' do
      @destination2.generic_fleets << @enemy_unit
      @destination3.generic_fleets << @allied_unit
      fleeing_fleet = @unit.flee! 1
      fleeing_fleet.planet.should == @destination3
    end

    it 'should go second to a neutral planet' do
      @destination1.squad = @enemy_squad
      @destination1.save
      @destination2.ground_squad = @enemy_squad
      @destination2.save
      fleeing_fleet = @unit.flee! 1
      fleeing_fleet.planet.should == @destination3
    end

    it 'should go last to an enemy planet' do
      @destination1.generic_fleets << @enemy_unit
      @destination2.generic_fleets << @enemy_unit
      @destination3.generic_fleets << @enemy_unit        
      fleeing_fleet = @unit.flee! 1
      fleeing_fleet.planet.should == @destination1 || fleeing_fleet.planet.should == @destination2 || fleeing_fleet.planet.should == @destination3  
    end
  end

end
