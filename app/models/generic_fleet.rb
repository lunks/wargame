class GenericFleet < ActiveRecord::Base
  default_scope :order => "squad_id ASC, moving DESC, destination_id ASC, generic_unit_id ASC, updated_at DESC"
  scope :owned_by, lambda {|squad| where(:squad => squad)}
  scope :moving, where(:moving => true)
  belongs_to :squad
  belongs_to :planet
  belongs_to :generic_unit
  belongs_to :destination, :class_name => "Planet"

  after_save :destroy_if_empty

  delegate :name, :to => :generic_unit

  def blast! quantity
    self.quantity -= quantity
    save
  end

  def capture! quantity, squad
    FacilityFleet.is_free
    captured_fleet = self.clone
    captured_fleet.update_attributes(:squad => squad, :quantity => quantity, :type => self.type, :balance => self.balance, :level => self.level, :fleet_name => self.fleet_name)
    captured_fleet.balance = 0 - self.capacity if captured_fleet.is_a? FacilityFleet
    captured_fleet.save
    self.quantity = self.quantity - quantity
    save
  end

  def sabotage!
    self.sabotaged = true
    self.save
  end


  def type?(type)
    generic_unit.is_a? type
  end

  def destroy_if_empty
    destroy if self.quantity == 0
  end

  def to_s
    name
  end

  def change_fleet_name name
    self.fleet_name = name
    save
  end

  def show_results
    round = Round.getInstance
    result = Result.where(:generic_fleet => self, :round => round).first
    results = ''
    if result.present? && round.attack?
      results << result.blasted.to_s+'d ' if result.blasted != nil
      results << result.fled.to_s+'f ' if result.fled != nil
      results << result.captured.to_s+'c ' if result.captured != nil
      results << 'sabot' if result.sabotaged == true
    end
    results
  end

  def to_label
    selling_price = (generic_unit.price * 0.50).to_i
    "#{quantity} #{name} - #{selling_price} cada"
  end

end
