#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe TaskMailer, type: :mailer do

  describe "task_completed_email" do
    let(:task) { create(:task, title: "Learn how to test mailers", size: 3) }
    let(:mail) { TaskMailer.task_completed_email(task) }

    it "renders the email" do
      expect(mail.subject).to eq("A task has been completed")
      expect(mail.to).to eq(["monitor@tasks.com"])
      expect(mail.body.encoded).to match(/Learn how to test mailers/)
    end
  end

end
