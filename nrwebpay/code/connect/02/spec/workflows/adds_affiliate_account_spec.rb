#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe AddsAffiliateAccount, :vcr do

  let(:user) { create(:user) }

  describe "creates an affiliate from a user" do

    let(:workflow) { AddsAffiliateAccount.new(user: user) }

    it "creates a an affiliate account with the required information" do
      workflow.run
      expect(workflow.affiliate).to have_attributes(
          name: user.name, country: "US",
          stripe_id: a_string_starting_with("acct_"), tag: a_truthy_value)
      expect(workflow).to be_a_success
    end

  end

end
