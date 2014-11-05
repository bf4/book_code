#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/core_ext/module/aliasing'

class Range
  # Extends the default Range#include? to support range comparisons.
  #  (1..5).include?(1..5) # => true
  #  (1..5).include?(2..3) # => true
  #  (1..5).include?(2..6) # => false
  #
  # The native Range#include? behavior is untouched.
  #  ('a'..'f').include?('c') # => true
  #  (5..9).include?(11) # => false
  def include_with_range?(value)
    if value.is_a?(::Range)
      # 1...10 includes 1..9 but it does not include 1..10.
      operator = exclude_end? && !value.exclude_end? ? :< : :<=
      include_without_range?(value.first) && value.last.send(operator, last)
    else
      include_without_range?(value)
    end
  end

  alias_method_chain :include?, :range
end
