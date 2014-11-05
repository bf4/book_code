#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "cases/helper"
require 'models/topic'
require 'models/task'

class DateTimeTest < ActiveRecord::TestCase
  def test_saves_both_date_and_time
    time_values = [1807, 2, 10, 15, 30, 45]
    now = DateTime.civil(*time_values)

    task = Task.new
    task.starting = now
    task.save!

    # check against Time.local_time, since some platforms will return a Time instead of a DateTime
    assert_equal Time.local_time(*time_values), Task.find(task.id).starting
  end

  def test_assign_empty_date_time
    task = Task.new
    task.starting = ''
    task.ending = nil
    assert_nil task.starting
    assert_nil task.ending
  end

  def test_assign_empty_date
    topic = Topic.new
    topic.last_read = ''
    assert_nil topic.last_read
  end

  def test_assign_empty_time
    topic = Topic.new
    topic.bonus_time = ''
    assert_nil topic.bonus_time
  end
end
