#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require_relative '../test/assertions'

module StringExtensions
  refine String do
    def reverse
      "esrever"
    end
  end
end

module StringStuff
  using StringExtensions
  "my_string".reverse    # => "esrever"

  assert_equals "esrever", "my_string".reverse
end

"my_string".reverse      # => "gnirts_ym"

assert_equals "gnirts_ym", "my_string".reverse
