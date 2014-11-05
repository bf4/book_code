#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/core_ext/string/conversions'
require 'active_support/core_ext/time/zones'

class String
  # Converts String to a TimeWithZone in the current zone if Time.zone or Time.zone_default
  # is set, otherwise converts String to a Time via String#to_time
  def in_time_zone(zone = ::Time.zone)
    if zone
      ::Time.find_zone!(zone).parse(self)
    else
      to_time
    end
  end
end
