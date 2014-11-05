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
      module Muscat
        include TimezoneDefinition
        
        timezone 'Asia/Muscat' do |tz|
          tz.offset :o0, 14060, 0, :LMT
          tz.offset :o1, 14400, 0, :GST
          
          tz.transition 1919, 12, :o1, 10464441137, 4320
        end
      end
    end
  end
end
