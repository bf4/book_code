#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'my_app'

class SalesTax
  RateUnavailableError = Class.new(StandardError)

  def initialize(tax_client = MyApp.tax_client)
    @tax_client = tax_client
  end

  def rate_for(zip)
    @tax_client.rates_for_location(zip).combined_rate
  rescue Taxjar::Error::NotFound
    raise RateUnavailableError, "Sales tax rate unavailable for zip: #{zip}"
  end
end
