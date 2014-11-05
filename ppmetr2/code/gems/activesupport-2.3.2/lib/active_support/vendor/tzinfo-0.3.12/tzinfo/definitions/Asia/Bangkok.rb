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
    module Asia
      module Bangkok
        include TimezoneDefinition
        
        timezone 'Asia/Bangkok' do |tz|
          tz.offset :o0, 24124, 0, :LMT
          tz.offset :o1, 24124, 0, :BMT
          tz.offset :o2, 25200, 0, :ICT
          
          tz.transition 1879, 12, :o1, 52006648769, 21600
          tz.transition 1920, 3, :o2, 52324168769, 21600
        end
      end
    end
  end
end
