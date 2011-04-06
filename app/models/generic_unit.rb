class GenericUnit < ActiveRecord::Base
  scope :allowed_for, lambda {|faction| where('faction_mask & ?', 2**FACTIONS.rindex(faction))}
  def factions=(factions)
    factions = [factions] if factions.is_a? String
    self.faction_mask = (factions & FACTIONS).map { |r| 2**FACTIONS.index(r) }.sum
  end

  def factions
    FACTIONS.reject do |r|
      ((self.faction_mask || 0) & 2**FACTIONS.index(r)).zero?
    end
  end

  def belongs?(faction)
    factions.include?(faction.to_s)
  end
end

