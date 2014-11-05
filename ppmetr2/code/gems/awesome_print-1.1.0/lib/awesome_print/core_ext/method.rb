#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Copyright (c) 2010-2012 Michael Dvorkin
#
# Awesome Print is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
#
# Method#name was intorduced in Ruby 1.8.7 so we define it here as necessary.
#
unless nil.method(:class).respond_to?(:name)
  class Method
    def name
      inspect.split(/[#.>]/)[-1]
    end
  end

  class UnboundMethod
    def name
      inspect.split(/[#.>]/)[-1]
    end
  end
end