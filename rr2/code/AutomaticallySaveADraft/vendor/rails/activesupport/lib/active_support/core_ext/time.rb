#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/time/calculations'
require File.dirname(__FILE__) + '/time/conversions'

class Time#:nodoc:
  include ActiveSupport::CoreExtensions::Time::Calculations
  include ActiveSupport::CoreExtensions::Time::Conversions
end
