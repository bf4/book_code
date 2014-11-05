#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'tzinfo/timezone_definition'

module TZInfo
  module Definitions
    module Pacific
      module Midway
        include TimezoneDefinition
        
        timezone 'Pacific/Midway' do |tz|
          tz.offset :o0, -42568, 0, :LMT
          tz.offset :o1, -39600, 0, :NST
          tz.offset :o2, -39600, 3600, :NDT
          tz.offset :o3, -39600, 0, :BST
          tz.offset :o4, -39600, 0, :SST
          
          tz.transition 1901, 1, :o1, 26086168721, 10800
          tz.transition 1956, 6, :o2, 58455071, 24
          tz.transition 1956, 9, :o1, 29228627, 12
          tz.transition 1967, 4, :o3, 58549967, 24
          tz.transition 1983, 11, :o4, 439038000
        end
      end
    end
  end
end
