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
      module Kuwait
        include TimezoneDefinition
        
        timezone 'Asia/Kuwait' do |tz|
          tz.offset :o0, 11516, 0, :LMT
          tz.offset :o1, 10800, 0, :AST
          
          tz.transition 1949, 12, :o1, 52558899121, 21600
        end
      end
    end
  end
end
