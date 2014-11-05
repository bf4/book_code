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
    module America
      module Guatemala
        include TimezoneDefinition
        
        timezone 'America/Guatemala' do |tz|
          tz.offset :o0, -21724, 0, :LMT
          tz.offset :o1, -21600, 0, :CST
          tz.offset :o2, -21600, 3600, :CDT
          
          tz.transition 1918, 10, :o1, 52312429831, 21600
          tz.transition 1973, 11, :o2, 123055200
          tz.transition 1974, 2, :o1, 130914000
          tz.transition 1983, 5, :o2, 422344800
          tz.transition 1983, 9, :o1, 433054800
          tz.transition 1991, 3, :o2, 669708000
          tz.transition 1991, 9, :o1, 684219600
          tz.transition 2006, 4, :o2, 1146376800
          tz.transition 2006, 10, :o1, 1159678800
        end
      end
    end
  end
end
