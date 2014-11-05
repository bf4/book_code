#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
ActiveSupport::Deprecation.warn 'You have required `active_support/core_ext/object/to_json`. ' \
  'This file will be removed in Rails 4.2. You should require `active_support/core_ext/object/json` ' \
  'instead.'

require 'active_support/core_ext/object/json'
