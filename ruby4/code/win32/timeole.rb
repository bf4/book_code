#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require_relative 'tapi'
require 'benchmark'
include Benchmark

bmbm(10) do |test|

  # test.report("Dynamic") do
  #   nm = WIN32OLE.new('TAPI.TAPI.1')
  #   10000.times { nm.CallHubs }
  # end

  test.report("Via proxy") do
    nm = TAPI_TAPI_1.new
    10000.times { nm.Addresses }
  end
end
