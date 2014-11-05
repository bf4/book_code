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
      module Majuro
        include TimezoneDefinition
        
        timezone 'Pacific/Majuro' do |tz|
          tz.offset :o0, 41088, 0, :LMT
          tz.offset :o1, 39600, 0, :MHT
          tz.offset :o2, 43200, 0, :MHT
          
          tz.transition 1900, 12, :o1, 1086923261, 450
          tz.transition 1969, 9, :o2, 58571881, 24
        end
      end
    end
  end
end
