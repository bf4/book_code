#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support'

module ActiveSupport
  autoload :Duration, 'active_support/duration'
  autoload :TimeWithZone, 'active_support/time_with_zone'
  autoload :TimeZone, 'active_support/values/time_zone'
end

require 'date'
require 'time'

require 'active_support/core_ext/time'
require 'active_support/core_ext/date'
require 'active_support/core_ext/date_time'

require 'active_support/core_ext/integer/time'
require 'active_support/core_ext/numeric/time'

require 'active_support/core_ext/string/conversions'
require 'active_support/core_ext/string/zones'
