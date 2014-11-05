#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
#
class Project < ActiveRecord::Base
  has_many :tasks, -> { order "project_order ASC" }

  #
  has_many :roles
  has_many :users, through: :roles
  #

  validates :name, presence: true

  #
  def self.all_public
    where(public: true)
  end
  #

  def total_size
    tasks.to_a.sum(&:size)
  end

  def size
    total_size
  end

  def remaining_size
    incomplete_tasks.to_a.sum(&:size)
  end

  def completed_velocity
    tasks.to_a.sum(&:points_toward_velocity)
  end
#

  def self.velocity_length_in_days
    21
  end

  def incomplete_tasks
    tasks.reject(&:complete?)
  end

  def done?
    incomplete_tasks.empty?
  end

  def current_rate
    completed_velocity * 1.0 / Project.velocity_length_in_days
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def undefined_rate?
    current_rate == 0
  end

  def on_schedule?
    return false if undefined_rate?
    (Date.today + projected_days_remaining) <= due_date
  end

  #
  def next_task_order
    return 1 if tasks.empty?
    tasks.last.project_order + 1
  end
  #

end
