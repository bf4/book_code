#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/core_ext/module/inclusion'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/module/attr_internal'
require 'active_support/core_ext/module/attr_accessor_with_default'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/introspection'
require 'active_support/core_ext/module/loading'
require 'active_support/core_ext/module/aliasing'
require 'active_support/core_ext/module/model_naming'
require 'active_support/core_ext/module/synchronization'

module ActiveSupport
  module CoreExtensions
    # Various extensions for the Ruby core Module class.
    module Module
      # Nothing here. Only defined for API documentation purposes.
    end
  end
end

class Module
  include ActiveSupport::CoreExtensions::Module
end
