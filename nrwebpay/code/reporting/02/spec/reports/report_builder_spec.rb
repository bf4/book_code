#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe ReportBuilder do

  let(:data_one) { OpenStruct.new(first_name: "Zach", last_name: "Paleozogt") }
  let(:data_two) { OpenStruct.new(first_name: "Doreen", last_name: "Green") }
  let(:builder) { ReportBuilder.new do
                    column(:first_name)
                    column(:last_name)
                  end }

  it "converts data into an array of hashes" do
    result = builder.build([data_one, data_two])
    expect(result).to eq(
        [{"First name" => "Zach", "Last name" => "Paleozogt"},
         {"First name" => "Doreen", "Last name" => "Green"}])
  end

  it "converts data into an array of hashes without friendly names" do
    builder.humanize_name = false
    result = builder.build([data_one, data_two])
    expect(result).to eq(
        [{"first_name" => "Zach", "last_name" => "Paleozogt"},
         {"first_name" => "Doreen", "last_name" => "Green"}])
  end

  it "handles CSV" do
    result = builder.build([data_one, data_two], format: :csv)
    expect(result).to eq("First name,Last name\nZach,Paleozogt\nDoreen,Green\n")
  end

end
