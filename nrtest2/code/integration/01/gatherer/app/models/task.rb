#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
class Task < ActiveRecord::Base

  belongs_to :project

  def self.complete
    where(["completed_at < ?", Time.current])
  end

  def mark_completed(date = nil)
    self.completed_at = (date || Time.current)
  end

  def complete?
    !completed_at.nil?
  end

  def part_of_velocity?
    return false unless complete?
    completed_at > Project.velocity_length_in_days.days.ago
  end

  def points_toward_velocity
    if part_of_velocity? then size else 0 end
  end

  def epic?
    size >= 5
  end

  def small?
    size <= 1
  end

  #
  def epic?
    size >= 5
  end

  def small?
    size <= 1
  end
  ##

end
