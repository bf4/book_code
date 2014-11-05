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
      module Tongatapu
        include TimezoneDefinition
        
        timezone 'Pacific/Tongatapu' do |tz|
          tz.offset :o0, 44360, 0, :LMT
          tz.offset :o1, 44400, 0, :TOT
          tz.offset :o2, 46800, 0, :TOT
          tz.offset :o3, 46800, 3600, :TOST
          
          tz.transition 1900, 12, :o1, 5217231571, 2160
          tz.transition 1940, 12, :o2, 174959639, 72
          tz.transition 1999, 10, :o3, 939214800
          tz.transition 2000, 3, :o2, 953384400
          tz.transition 2000, 11, :o3, 973342800
          tz.transition 2001, 1, :o2, 980596800
          tz.transition 2001, 11, :o3, 1004792400
          tz.transition 2002, 1, :o2, 1012046400
        end
      end
    end
  end
end
