#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
# validate me
require 'rspec'

RSpec.configure do |config|
  config.define_derived_metadata do |meta|
    # Sets the flag unconditionally;
    # doesn't allow examples to opt out
    meta[:aggregate_failures] = true
  end
end

RSpec.describe 'Billing', aggregate_failures: false do
  context 'using the fake payment service' do
    before do
      expect(MyApp.config.payment_gateway).to include('sandbox')
    end

    # ...
  end
end
