#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'date'
require 'active_support/core_ext/date/behavior'
require 'active_support/core_ext/date/calculations'
require 'active_support/core_ext/date/conversions'

class Date#:nodoc:
  include ActiveSupport::CoreExtensions::Date::Behavior
  include ActiveSupport::CoreExtensions::Date::Calculations
  include ActiveSupport::CoreExtensions::Date::Conversions
end
