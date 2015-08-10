#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'rails_helper'

describe User do
  describe "email" do
    it "does not allow non-company email addresses" do
      user = User.create(email: "foo@bar.com")
      expect(user.valid?).to eq(false)
    end

    it "does allows company email addresses" do
      user = User.create(email: "foo@example.com", password: "qwertyuiop", password_confirmation: "qwertyuiop")
      expect(user.valid?).to eq(true)
      user.save!
    end

    it "does not allow existing users to circumvent the email address policy" do
      user = User.create(email: "foo@example.com", password: "qwertyuiop", password_confirmation: "qwertyuiop")
      user.save!
      expect {
        user.update_attribute(:email, "foo@bar.com")
      }.to raise_error(/new row for relation .users. violates check constraint/)
    end
  end
end
