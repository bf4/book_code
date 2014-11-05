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
    module Atlantic
      module South_Georgia
        include TimezoneDefinition
        
        timezone 'Atlantic/South_Georgia' do |tz|
          tz.offset :o0, -8768, 0, :LMT
          tz.offset :o1, -7200, 0, :GST
          
          tz.transition 1890, 1, :o1, 1627673806, 675
        end
      end
    end
  end
end
