#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe Payment, type: :model do

  describe "generate_reference" do

    before(:example) do
      allow(SecureRandom).to receive(:hex).and_return("first", "second")
    end

    it "generates a reference" do
      expect(Payment.generate_reference).to eq("first")
    end

    it "avoids duplicates" do
      create(:payment, reference: "first", user: create(:user))
      expect(Payment.generate_reference).to eq("second")
    end

  end

end
