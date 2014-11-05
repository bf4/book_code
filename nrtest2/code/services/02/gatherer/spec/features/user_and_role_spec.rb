#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require "rails_helper"

describe "with users and roles" do

  def log_in_as(user)
    visit new_user_session_path
    fill_in("user_email", :with => user.email)
    fill_in("user_password", :with => user.password)
    click_button("Sign in")
  end

  let(:user) { User.create(email: "test@example.com", password: "password") }

  it "allows a logged in user to view the project index page" do
    log_in_as(user)
    visit(projects_path)
    expect(current_path).to eq(projects_path)
  end

  it "does not allow user to see the project page if not logged in" do
    visit(projects_path)
    expect(current_path).to eq(new_user_session_path)
  end

end
