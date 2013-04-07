class Tradeport < ActiveRecord::Base
  belongs_to :generic_unit
  belongs_to :planet

  after_save :destroy_if_empty

  delegate :name, :to => :generic_unit
  delegate :price, :to => :generic_unit

  def self.produce_units
    #depois filtrar onde planet.tradeport == yes
    Planet.all.each do |planet| 
      random_unit = Unit.all[rand(Unit.all.count - 1)]
      Tradeport.create(:planet => planet,:generic_unit => random_unit, :quantity => 1, :negotiation_rate => 50)
    end 
  end

  def show_negotiation_rate
    "#{self.generic_unit.name} - #{self.negotiation_rate}% - #{self.generic_unit.price * self.negotiation_rate / 100}"
  end

  def sell_unit squad, quantity
    selling_price = self.generic_unit.price * negotiation_rate / 100
    if squad.credits >= selling_price * quantity
      GenericFleet.create(:generic_unit_id => self.generic_unit.id, :planet => self.planet, :squad => squad, :fleet_name => squad.name, :quantity => quantity)     
      squad.debit selling_price * quantity
      self.quantity -= quantity
      self.save
    end
  end

  def self.buy_unit planet, unit, quantity
    buying_price = unit.generic_unit.price * 0.50
    Tradeport.create(:planet => planet,:generic_unit_id => unit.generic_unit.id, :quantity => quantity, :negotiation_rate => 50)
    unit.squad.deposit buying_price * quantity
    unit.quantity -= quantity
    unit.save  
  end

  def to_s
    name
  end
 
 def to_label
    selling_price = price * negotiation_rate / 100
    "#{quantity} #{name} (#{negotiation_rate}% off $#{selling_price})"
  end

  def destroy_if_empty
    destroy if self.quantity == 0
  end
  

end
