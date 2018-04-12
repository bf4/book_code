#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
class Task < ApplicationRecord
  include Sizeable

  belongs_to :project, required: false

  def mark_completed(date = Time.current)
    self.completed_at = date
  end

  def complete?
    completed_at.present?
  end

  def part_of_velocity?
    return false unless complete?
    completed_at > Project.velocity_length_in_days.days.ago
  end

  def points_toward_velocity
    part_of_velocity? ? size : 0
  end

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
  def previous_task
    project.tasks.find_by(project_order: project_order - 1)
  end

  def next_task
    project.tasks.find_by(project_order: project_order + 1)
  end

  def swap_order_with(other)
    other.project_order, self.project_order = project_order, other.project_order
    save
    other.save
  end

  def move_up
    swap_order_with(previous_task) unless first_in_project?
  end

  def move_down
    swap_order_with(next_task) unless last_in_project?
  end

  #
end
