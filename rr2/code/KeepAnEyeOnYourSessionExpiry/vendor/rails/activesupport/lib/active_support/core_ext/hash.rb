#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/hash/keys'
require File.dirname(__FILE__) + '/hash/indifferent_access'
require File.dirname(__FILE__) + '/hash/reverse_merge'
require File.dirname(__FILE__) + '/hash/conversions'
require File.dirname(__FILE__) + '/hash/diff'

class Hash #:nodoc:
  include ActiveSupport::CoreExtensions::Hash::Keys
  include ActiveSupport::CoreExtensions::Hash::IndifferentAccess
  include ActiveSupport::CoreExtensions::Hash::ReverseMerge
  include ActiveSupport::CoreExtensions::Hash::Conversions
  include ActiveSupport::CoreExtensions::Hash::Diff
end
