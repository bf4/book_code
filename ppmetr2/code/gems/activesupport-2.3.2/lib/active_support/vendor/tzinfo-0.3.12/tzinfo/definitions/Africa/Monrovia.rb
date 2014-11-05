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
    module Africa
      module Monrovia
        include TimezoneDefinition
        
        timezone 'Africa/Monrovia' do |tz|
          tz.offset :o0, -2588, 0, :LMT
          tz.offset :o1, -2588, 0, :MMT
          tz.offset :o2, -2670, 0, :LRT
          tz.offset :o3, 0, 0, :GMT
          
          tz.transition 1882, 1, :o1, 52022445047, 21600
          tz.transition 1919, 3, :o2, 52315600247, 21600
          tz.transition 1972, 5, :o3, 73529070
        end
      end
    end
  end
end
