#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/core_ext/module/anonymous'
require 'active_support/core_ext/string/inflections'

class Module
  def reachable? #:nodoc:
    !anonymous? && name.safe_constantize.equal?(self)
  end
end
