#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'net/http'
require 'base64'
payload = Base64.encode64(Marshal.dump({:x => 123, :y => 456}))
Net::HTTP.start("localhost", 3000) do |http|
  http.post "/check/index", payload, {"Content-Type" => "application/rubymarshal"}
end
