#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'bigdecimal'
require 'bigdecimal/util'

class BigDecimal
  DEFAULT_STRING_FORMAT = 'F'
  def to_formatted_s(*args)
    if args[0].is_a?(Symbol)
      super
    else
      format = args[0] || DEFAULT_STRING_FORMAT
      _original_to_s(format)
    end
  end
  alias_method :_original_to_s, :to_s
  alias_method :to_s, :to_formatted_s
end
