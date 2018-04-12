#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe User, type: :model do
  let(:project) { create(:project) }
  let(:user) { create(:user) }

  it "cannot view a project it is not a part of" do
    expect(user.can_view?(project)).to be_falsy
  end

  it "can view a project it is a part of" do
    Role.create(user: user, project: project)
    expect(user.can_view?(project)).to be_truthy
  end
end
