#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "csv"

CSV.foreach("data/shopping-with-header.csv", headers: true) do |record|
  record["Price"]
  # => "£1.20"
  #    , "£0.80"
  #    , "£10.20"
  #    , "£5.20"
  #    , "£6.35"
  #    , "£1.20"
  #    , "£3.99"
end
