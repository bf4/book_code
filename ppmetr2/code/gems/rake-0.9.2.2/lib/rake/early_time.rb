#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rake

  # EarlyTime is a fake timestamp that occurs _before_ any other time value.
  class EarlyTime
    include Comparable
    include Singleton

    def <=>(other)
      -1
    end

    def to_s
      "<EARLY TIME>"
    end
  end

  EARLY = EarlyTime.instance
end
