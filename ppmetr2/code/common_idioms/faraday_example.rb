#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'faraday'

conn = Faraday.new("https://twitter.com/search") do |faraday|
  faraday.response      :logger
  faraday.adapter       Faraday.default_adapter
  faraday.params["q"]   = "ruby"
  faraday.params["src"] = "typd"
end

response = conn.get
response.status           # => 200

require_relative '../test/assertions'
assert_equals 200, response.status
