require 'spec_helper'

describe GenericFleet do

  it {should belong_to :squad}
  it {should belong_to :planet}
  it {should belong_to :generic_unit}
  it {should belong_to :destination}
  it {should belong_to :carried_by}

  let(:unit) {Factory :generic_fleet}
  let(:trooper) {Factory :trooper}
  let(:capital_ship) {Factory :capital_ship}
  let(:fighter) {Factory :fighter}
  let(:armament) {Factory :armament}
  let(:facility_unit) {Factory :facility_fleet}
  let(:facility) {Factory :facility}

  context 'managing fleets' do
    before(:each) do
      GenericFleet.destroy_all
      unit.generic_unit = capital_ship
      unit.quantity = 1
      unit.save
    end
    it 'should give a fleet name' do
      unit.change_fleet_name 'Nomeada'
      unit.fleet_name.should == 'Nomeada'
    end
    it 'should verify unit type' do
      unit.type?(Trooper).should be_false
      unit.type?(CapitalShip).should be_true
    end
    it 'should show its unit name' do
      unit.name.should == capital_ship.name
    end
    it 'should show posted results on dashboard' do
      result = Factory :result
      planet = Factory :planet
      round = Round.getInstance
      round.attack = true
      round.save
      result.planet = planet
      result.round = round
      result.blasted = 1
      result.fled = 1
      result.captured = 1
      result.captor = Factory :squad
      result.sabotaged = true
      result.generic_fleet = unit
      result.save!
      unit.show_results.should == '1d 1f 1c sabot'
    end
    it 'should be destroyed if empty' do
      GenericFleet.all.should_not be_empty
      unit.quantity -= 1
      unit.save
      GenericFleet.all.should be_empty
    end

    it 'should be loaded into a carrier ship' do
      carrier = Factory(:generic_fleet, :generic_unit => capital_ship)
      unit.load_in carrier, 1
      unit.carrier.should be carrier
      carrier.cargo.first.should == unit
    end
    it 'should be partially loaded into a carrier ship' do
      carrier = Factory(:generic_fleet, :generic_unit => capital_ship)
      unit.quantity = 10
      unit.save
      unit.load_in carrier, 6
      carrier.cargo.first.should == unit
      carrier.cargo.first.quantity.should == 6
      not_loaded_fleet = GenericFleet.where(:quantity => 4).first
      not_loaded_fleet.quantity.should == 4
    end
    it 'should be unloaded from a carrier ship' do
      carrier = Factory(:generic_fleet, :generic_unit => capital_ship, :quantity => 1)
      unit.load_in carrier, 1
      unit.carrier.should be carrier
      unit.unload_from carrier, 1
      unit.carrier.should be_nil
    end
    it 'should be partially unloaded from a carrier ship' do
      carrier = Factory(:generic_fleet, :generic_unit => capital_ship, :quantity => 1)
      unit.quantity = 10
      unit.save
      unit.load_in carrier, 10
      unit.carrier.should be carrier
      unit.unload_from carrier, 6
      carrier.cargo.first.should == unit
      carrier.cargo.first.quantity.should == 4
      unloaded_fleet = GenericFleet.where(:quantity => 6).first
      unloaded_fleet.quantity.should == 6
    end
    it 'should arm a fighter' do
      fighter = Factory(:generic_fleet, :generic_unit => fighter, :quantity => 1)
      unit.load_in fighter, 1
      unit.carrier.should be fighter
    end
    it 'should arm a full group of fighters' do
      fighter = Factory(:generic_fleet, :generic_unit => fighter, :quantity => 10)
      unit.generic_unit = armament
      unit.quantity = 10
      unit.save
      unit.load_in fighter, 10
      unit.carrier.should be fighter
      fighter.cargo.first.should == unit
      unit = GenericFleet.where(:generic_unit => armament).first
      unit.quantity.should == 1
    end

  end


  context 'blast units' do
    before(:each) do
      unit.quantity = 1
    end
    it 'should remove units from the current fleet' do
      unit.blast! 1
      unit.quantity.should be 0
    end
  end

  context 'capturing units' do
    let(:squad) {Factory :squad}
    before(:each) do
      unit.quantity = 1
    end
    it 'should remove units from the current fleet' do
      unit.capture! 1, squad
      unit.quantity.should be 0
    end
    it 'should remove fleet if quantity equals zero' do
      unit.capture! 1, squad
      unit.should be_new_record
    end
    it 'should transfer fleet to another squad' do
      unit.capture! 1, squad
      squad.generic_fleets.count.should be 1
    end

    context 'related to captured fleet' do
      before(:each) do
        unit.capture! 1, squad
      end
      let(:captured_unit) {squad.generic_fleets.first}
      it 'should have the captured quantity' do
        captured_unit.quantity.should be 1
      end
    end

    context 'related to captured facility fleet' do
      it 'should reset balance when captured' do
        facility_unit.balance = 100
        facility_unit.producing_unit = capital_ship
        facility_unit.save
        facility_unit.capture! 1,squad
        captured_facility = squad.generic_fleets.first
        capacity = captured_facility.generic_unit.price / 3
        captured_facility.balance.should == (capacity - capacity * 2).to_i
      end
      it 'should reset secondary producing unit when captured' do
        facility_unit.balance = 1000
        facility_unit.producing_unit2 = trooper
        facility_unit.save
        facility_unit.capture! 1,squad
        captured_facility = squad.generic_fleets.first
        captured_facility.producing_unit2.should be_nil
      end
    end

  end

  context 'sabotaging units' do
    before(:each) do
      unit.quantity = 1
    end
    it 'should remove flag unit as sabotaged' do
      unit.sabotage!
      unit.sabotaged.should be_true
    end
  end

end

