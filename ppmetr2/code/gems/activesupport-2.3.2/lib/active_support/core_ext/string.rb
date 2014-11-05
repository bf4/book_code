#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/string/conversions'
require 'active_support/core_ext/string/access'
require 'active_support/core_ext/string/starts_ends_with'
require 'active_support/core_ext/string/iterators'
require 'active_support/core_ext/string/multibyte'
require 'active_support/core_ext/string/xchar'
require 'active_support/core_ext/string/filters'
require 'active_support/core_ext/string/behavior'

class String
  include ActiveSupport::CoreExtensions::String::Access
  include ActiveSupport::CoreExtensions::String::Conversions
  include ActiveSupport::CoreExtensions::String::Filters
  include ActiveSupport::CoreExtensions::String::Inflections
  include ActiveSupport::CoreExtensions::String::StartsEndsWith
  include ActiveSupport::CoreExtensions::String::Iterators
  include ActiveSupport::CoreExtensions::String::Behavior
  include ActiveSupport::CoreExtensions::String::Multibyte
end
