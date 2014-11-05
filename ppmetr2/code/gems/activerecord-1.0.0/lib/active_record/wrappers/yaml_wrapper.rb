#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'yaml'

module ActiveRecord
  module Wrappings #:nodoc:
    class YamlWrapper < AbstractWrapper #:nodoc:
      def wrap(attribute)   attribute.to_yaml end
      def unwrap(attribute) YAML::load(attribute) end
    end

    module ClassMethods #:nodoc:
      # Wraps the attribute in Yaml encoding
      def wrap_in_yaml(*attributes) wrap_with(YamlWrapper, attributes) end
    end
  end
end