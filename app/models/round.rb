class Round < ActiveRecord::Base
  def self.getInstance
    Round.last
  end

  def done_moving?
    done = true
    Squad.all.each do |squad|
      done = false if squad.move.blank?
    end
    save
    done
  end

  def who?
    Squad.all.each do |squad|
      return squad if squad.move? == false
    end
  end
end

