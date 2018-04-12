#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "test_helper" 

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
end
