#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  setup do
    @project = FactoryBot.create(:project)
  end

  def add_one_task
    @task = FactoryBot.create(:task, project: @project)
  end

  def add_many_tasks
    newly_done = FactoryBot.build(:task, :newly_complete)
    old_done = FactoryBot.build(:task, :long_complete, :small)
    small_not_done = FactoryBot.build(:task, :small)
    large_not_done = FactoryBot.build(:task, :large)
    @project.tasks = [newly_done, old_done, small_not_done, large_not_done]
    @project.save!
  end

  test "a project with no tasks is done" do
    assert(@project.done?)
  end

  test "a project with no tests is estimated" do
    assert_equal(0, @project.completed_velocity)
    assert_equal(0, @project.current_rate)
    assert(@project.projected_days_remaining.nan?)
    refute(@project.on_schedule?)
  end

  test "a project with an incomplete task is not done" do
    add_one_task
    refute(@project.done?)
  end

  test "a project with complete tasks is done" do
    add_one_task
    @task.mark_completed
    @task.save
    assert(@project.done?)
  end

  test "can calculate sizes" do
    add_many_tasks
    assert_equal(10, @project.size)
    assert_equal(6, @project.incomplete_tasks.map(&:size).sum)
    assert_equal(3, @project.completed_velocity)
    assert_equal(1.0 / 7, @project.current_rate)
    assert_equal(42, @project.projected_days_remaining)
  end
end
