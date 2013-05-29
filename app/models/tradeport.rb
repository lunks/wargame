class Tradeport < ActiveRecord::Base
  belongs_to :generic_unit
  belongs_to :squad

  after_save :destroy_if_empty

  delegate :name, :to => :generic_unit
  delegate :price, :to => :generic_unit

  def self.start
    2.times do
      Squad.all.each do |squad|
        random_unit = Unit.where("price > ?", 105).reject! { |unit| unit.is_a? Commander }[rand(Unit.where("price > ?", 105).reject! { |unit| unit.is_a? Commander }.count)]
        if random_unit.price >= 1000
          Tradeport.create(:generic_unit_id => random_unit.id, :squad_id => squad.id, :quantity => 1, :negotiation_rate => 50)
        else
          quantity = (1000 / random_unit.price).to_i
          Tradeport.create(:generic_unit_id => random_unit.id, :squad_id => squad.id, :quantity => quantity, :negotiation_rate => 50)
        end
      end
    end
    Tradeport.all.each do |tradeport|
      tradeport.negotiation_rate = 50 + rand(90 - 50)
      tradeport.save
    end
  end

  def show_negotiation_rate
    "#{self.generic_unit.name} - #{self.negotiation_rate}% - #{self.generic_unit.price * self.negotiation_rate / 100}"
  end

  def sell_unit planet, squad, quantity
    selling_price = self.generic_unit.price * negotiation_rate / 100
    if squad.credits >= selling_price * quantity
      Fleet.create_from_facility self.generic_unit, quantity, planet, squad
      squad.debit selling_price * quantity
      self.quantity -= quantity
      self.save
    end
  end

  def self.buy_unit unit, quantity
    buying_price = unit.generic_unit.price * 0.50
    a = Tradeport.where(:generic_unit_id => unit.generic_unit.id).first
    if a.present?
      a.quantity += quantity
      a.save
    else
      Tradeport.create(:generic_unit_id => unit.generic_unit.id, :quantity => quantity, :negotiation_rate => 50)
    end
    unit.squad.deposit buying_price * quantity
    unit.quantity -= quantity
    unit.save  
  end

  def to_s
    name
  end
 
  def to_label
    selling_price = price * negotiation_rate / 100
    "#{quantity} #{name} (#{100 - negotiation_rate}% off - #{selling_price} cada)"
  end

  def destroy_if_empty
    destroy if self.quantity == 0
  end
  

end
