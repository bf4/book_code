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
      module Port_Moresby
        include TimezoneDefinition
        
        timezone 'Pacific/Port_Moresby' do |tz|
          tz.offset :o0, 35320, 0, :LMT
          tz.offset :o1, 35312, 0, :PMMT
          tz.offset :o2, 36000, 0, :PGT
          
          tz.transition 1879, 12, :o1, 5200664597, 2160
          tz.transition 1894, 12, :o2, 13031248093, 5400
        end
      end
    end
  end
end
