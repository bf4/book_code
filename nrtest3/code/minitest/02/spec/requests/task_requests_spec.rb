#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe "task requests" do

  before(:example) do
    ActionMailer::Base.deliveries.clear 
  end

  let(:task) { create(:task, title: "Learn how to test mailers", size: 3) }

  it "does not send an email if a task is not completed" do
    patch(task_path(id: task.id), params: {task: {completed: false}})
    expect(ActionMailer::Base.deliveries.size).to eq(0)
  end

  #
  it "sends email when task is completed" do
    patch(task_path(id: task.id), params: {task: {completed: true}})
    expect(ActionMailer::Base.deliveries.size).to eq(1)
    email = ActionMailer::Base.deliveries.first
    expect(email.subject).to eq("A task has been completed")
    expect(email.to).to eq(["monitor@tasks.com"])
    expect(email.body.to_s).to match(/Learn how to test mailers/)
  end
  #

end
