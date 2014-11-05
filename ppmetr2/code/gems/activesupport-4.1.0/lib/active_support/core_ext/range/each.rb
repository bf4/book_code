#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/core_ext/module/aliasing'

class Range #:nodoc:

  def each_with_time_with_zone(&block)
    ensure_iteration_allowed
    each_without_time_with_zone(&block)
  end
  alias_method_chain :each, :time_with_zone

  def step_with_time_with_zone(n = 1, &block)
    ensure_iteration_allowed
    step_without_time_with_zone(n, &block)
  end
  alias_method_chain :step, :time_with_zone

  private
  def ensure_iteration_allowed
    if first.is_a?(Time)
      raise TypeError, "can't iterate from #{first.class}"
    end
  end
end
