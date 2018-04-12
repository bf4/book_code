#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe StripeAccount, :vcr do

  describe "updating" do
    let(:affiliate_user) { create(:user) }
    let(:affiliate_workflow) {
      AddsAffiliateAccount.new(user: affiliate_user) }
    let(:account) { affiliate_workflow.account }
    let(:values) { {
        legal_entity: {first_name: "Noel",
                       dob: {day: 22, month: 1, year: 1971}}} }

    it "updates the account from a hash" do
      affiliate_workflow.run
      account.update(values)
      expect(account.account.legal_entity.first_name).to eq("Noel")
      expect(account.account.legal_entity.dob.day).to eq(22)
      expect(account.account.legal_entity.dob.month).to eq(1)
      expect(account.account.legal_entity.dob.year).to eq(1971)
    end

  end

end
