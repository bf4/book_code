#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe Affiliate, type: :model do

  let(:affiliate) { Affiliate.new }

  it "converts field names to form attributes" do
    expect(affiliate.convert_form_name("attribute")).to eq(
        "account[attribute]")
    expect(affiliate.convert_form_name("legal_entity.type")).to eq(
        "account[legal_entity][type]")
    expect(affiliate.convert_form_name("legal_entity.dob.year")).to eq(
        "account[legal_entity][dob][year]")
  end

  it "gives a list of field names" do
    affiliate.verification_needed = [
        "legal_entity.type", "legal_entity.dob.year"
    ]
    expect(affiliate.verification_form_names).to eq(
        ["account[legal_entity][type]", "account[legal_entity][dob][year]"])
  end
end
