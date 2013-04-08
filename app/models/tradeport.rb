class Tradeport < ActiveRecord::Base
  belongs_to :generic_unit

  after_save :destroy_if_empty

  delegate :name, :to => :generic_unit
  delegate :price, :to => :generic_unit

  def self.start
    random_unit = Unit.all[rand(Unit.all.count - 1)]
    Tradeport.create(:generic_unit => random_unit, :quantity => 1, :negotiation_rate => 50)
    Tradeport.all.each do |tradeport|
      tradeport.negotiation_rate = 20 + rand(50 - 20)
      tradeport.save
    end
  end

  def show_negotiation_rate
    "#{self.generic_unit.name} - #{self.negotiation_rate}% - #{self.generic_unit.price * self.negotiation_rate / 100}"
  end

  def sell_unit planet, squad, quantity
    selling_price = self.generic_unit.price * negotiation_rate / 100
    if squad.credits >= selling_price * quantity
      a = Fleet.where(:generic_unit_id => self.generic_unit.id, :squad => squad, :planet => planet, :moving => nil).first
      if a.present?
        a.quantity += quantity
        a.save
      else
        Fleet.create(:generic_unit_id => self.generic_unit.id, :planet_id => planet.id, :squad_id => squad.id, :fleet_name => squad.name, :quantity => quantity, :type => generic_unit.type) 
      end
      squad.debit selling_price * quantity
      self.quantity -= quantity
      self.save
    end
  end

  def self.buy_unit unit, quantity
    buying_price = unit.generic_unit.price * 0.50
    Tradeport.create(:generic_unit_id => unit.generic_unit.id, :quantity => quantity, :negotiation_rate => 50)
    unit.squad.deposit buying_price * quantity
    unit.quantity -= quantity
    unit.save  
  end

  def to_s
    name
  end
 
  def to_label
    selling_price = price * negotiation_rate / 100
    "#{quantity} #{name} (#{negotiation_rate}% OFF - #{selling_price} cada)"
  end

  def destroy_if_empty
    destroy if self.quantity == 0
  end
  

end
