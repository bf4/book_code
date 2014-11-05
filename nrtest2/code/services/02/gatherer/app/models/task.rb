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
  belongs_to :user

  def self.complete
    where(["completed_at < ?", Time.current])
  end

  def mark_completed(date = nil)
    self.completed_at = (date || Time.current)
  end

  def complete?
    !completed_at.nil?
  end

  def counts_toward_velocity?
    return false unless complete?
    completed_at > Project.velocity_length_in_days.days.ago
  end

  def points_toward_velocity
    if counts_toward_velocity? then size else 0 end
  end

  #
  def epic?
    size >= 5
  end

  def small?
    size <= 1
  end
  #

  #
  def first_in_project?
    return false unless project
    project.tasks.first == self
  end

  def last_in_project?
    return false unless project
    project.tasks.last == self
  end
  #

  #
  def my_place_in_project
    project.tasks.index(self)
  end

  def previous_task
    project.tasks[my_place_in_project - 1]
  end

  def next_task
    project.tasks[my_place_in_project + 1]
  end

  def swap_order_with(other)
    other.project_order, self.project_order =
        self.project_order, other.project_order
    self.save
    other.save
  end

  def move_up
    swap_order_with(previous_task)
  end

  def move_down
    swap_order_with(next_task)
  end
  #

end
