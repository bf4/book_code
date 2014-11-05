#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  setup do
    ActionMailer::Base.deliveries.clear 
  end

  test "on update with no completion, no email is sent" do
    task = Task.create!(title: "Write section on testing mailers",
        size: 2)
    patch :update, id: task.id, task: {size: 3}
    assert_equal 0, ActionMailer::Base.deliveries.size 
  end

end
