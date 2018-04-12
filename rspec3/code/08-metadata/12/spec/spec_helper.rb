#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
RSpec.configure do |config|
  config.filter_run_when_matching :focus
end

RSpec.describe "With no examples focused" do
  it "only runs if no other examples are focused" do
  end
end

RSpec.describe "With an example focused" do
  it "runs alone when focused", :focus => !!ENV['FOCUS_AN_EXAMPLE'] do
  end
end
