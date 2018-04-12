#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe Task do
  let(:task) { Task.new }

  it "does not have a new task as complete" do
    expect(task).not_to be_complete
  end

  it "allows us to complete a task" do
    task.mark_completed
    expect(task).to be_complete
  end
end
