#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/../../inflector' unless defined? Inflector
module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Integer #:nodoc:
      module Inflections
        # 1.ordinalize  # => "1st"
        # 3.ordinalize  # => "3rd"
        # 10.ordinalize # => "10th"
        def ordinalize
          Inflector.ordinalize(self)
        end
      end
    end
  end
end
