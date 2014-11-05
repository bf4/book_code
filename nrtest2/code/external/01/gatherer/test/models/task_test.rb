#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'test_helper' 

class TaskTest < ActiveSupport::TestCase

  test "a completed task is complete" do
    task = Task.new
    refute(task.complete?)
    task.mark_completed
    assert(task.complete?)
  end

  test "an uncompleted task does not count toward velocity" do
    task = Task.new(size: 3)
    refute(task.part_of_velocity?)
    assert_equal(0, task.points_toward_velocity)
  end

  test "a task completed long ago does not count toward velocity" do
    task = Task.new(size: 3)
    task.mark_completed(6.months.ago)
    refute(task.part_of_velocity?)
    assert_equal(0, task.points_toward_velocity)
  end

  test "a task completed recently counts toward velocity" do
    task = Task.new(size: 3)
    task.mark_completed(1.day.ago)
    assert(task.part_of_velocity?)
    assert_equal(3, task.points_toward_velocity)
  end

  test "it finds completed tasks" do
    Task.delete_all
    complete = Task.create(completed_at: 1.day.ago, title: "Completed")
    incomplete = Task.create(completed_at: nil, title: "Not Completed")
    assert_equal([complete], Task.complete.to_a)
  end

  #
  test "it finds that a test is first or last" do
    project = Project.create!(name: "Project")
    first = project.tasks.create!(project_order: 1)
    second = project.tasks.create!(project_order: 2)
    third = project.tasks.create!(project_order: 3)
    assert first.first_in_project?
    refute first.last_in_project?
    refute second.first_in_project?
    refute second.last_in_project?
    refute third.first_in_project?
    assert third.last_in_project?
  end
  #

  #
  def project_with_three_tasks
    @project = Project.create!(name: "Project")
    @first = @project.tasks.create!(project_order: 1)
    @second = @project.tasks.create!(project_order: 2)
    @third = @project.tasks.create!(project_order: 3)
  end

  test "it can move up" do
    project_with_three_tasks
    assert_equal @first, @second.previous_task
    @second.move_up
    assert_equal 2, @first.reload.project_order
    assert_equal 1, @second.reload.project_order
  end

  test "it can move down" do
    project_with_three_tasks
    assert_equal @third, @second.next_task
    @second.move_down
    assert_equal 2, @third.reload.project_order
    assert_equal 3, @second.reload.project_order
  end
  #

end
