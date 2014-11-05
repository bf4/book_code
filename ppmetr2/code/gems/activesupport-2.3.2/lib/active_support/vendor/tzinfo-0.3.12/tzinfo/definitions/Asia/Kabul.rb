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
      module Kabul
        include TimezoneDefinition
        
        timezone 'Asia/Kabul' do |tz|
          tz.offset :o0, 16608, 0, :LMT
          tz.offset :o1, 14400, 0, :AFT
          tz.offset :o2, 16200, 0, :AFT
          
          tz.transition 1889, 12, :o1, 2170231477, 900
          tz.transition 1944, 12, :o2, 7294369, 3
        end
      end
    end
  end
end
