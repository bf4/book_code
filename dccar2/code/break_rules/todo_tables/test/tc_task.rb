#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
require 'test/unit'
require 'todo/task'
require 'mocha/setup'
require 'stringio'

class TaskTest < Test::Unit::TestCase

  def setup
  end

  def teardown
    File.unstub(:open)
  end

  def test_raises_error_when_no_tasks
    File.stubs(:open).yields("")

    ex = assert_raises RuntimeError do
      Todo::Task.new_task("foo.txt",[])
    end
    assert_equal "You must provide tasks on the command-line or standard input",
                 ex.message
  end

  def test_proper_working
    string_io = StringIO.new
    File.stubs(:open).yields(string_io)

    Todo::Task.new_task("foo.txt","This is a task")

    assert_match /^This is a task,/,string_io.string
  end

  def test_cannot_open_file
    ex_msg = "Operation not permitted"
    File.stubs(:open).raises(Errno::EPERM.new(ex_msg))
    ex = assert_raises RuntimeError do
      Todo::Task.new_task("foo.txt","This is a task")
    end
    assert_match /^Couldn't open foo.txt for appending: #{ex_msg}/,ex.message
  end
end
