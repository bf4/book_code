#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'taxjar'
require 'dotenv'
Dotenv.load('api_creds.env')

Address = Struct.new(:zip) do
  def initialize(zip:)
    super(zip)
  end
end

Item = Struct.new(:cost) do
  def initialize(cost:)
    super(cost)
  end
end

module MyApp
  def self.tax_client
    @tax_client ||= Taxjar::Client.new(api_key: ENV['TAXJAR_API_KEY'])
  end
end
