#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'active_support/deprecation'
require 'active_support/ordered_options'
require 'active_support/core_ext/hash/deep_dup'
require 'rails/paths'
require 'rails/rack'

module Rails
  module Configuration
    class MiddlewareStackProxy #:nodoc:
      def initialize
        @operations = []
      end

      def insert_before(*args, &block)
        @operations << [:insert_before, args, block]
      end

      alias :insert :insert_before

      def insert_after(*args, &block)
        @operations << [:insert_after, args, block]
      end

      def swap(*args, &block)
        @operations << [:swap, args, block]
      end

      def use(*args, &block)
        @operations << [:use, args, block]
      end

      def delete(*args, &block)
        @operations << [:delete, args, block]
      end

      def merge_into(other)
        @operations.each do |operation, args, block|
          other.send(operation, *args, &block)
        end
        other
      end
    end

    class Generators #:nodoc:
      attr_accessor :aliases, :options, :templates, :fallbacks, :colorize_logging
      attr_reader :hidden_namespaces

      def initialize
        @aliases = Hash.new { |h,k| h[k] = {} }
        @options = Hash.new { |h,k| h[k] = {} }
        @fallbacks = {}
        @templates = []
        @colorize_logging = true
        @hidden_namespaces = []
      end

      def initialize_copy(source)
        @aliases = @aliases.deep_dup
        @options = @options.deep_dup
        @fallbacks = @fallbacks.deep_dup
        @templates = @templates.dup
      end

      def hide_namespace(namespace)
        @hidden_namespaces << namespace
      end

      def method_missing(method, *args)
        method = method.to_s.sub(/=$/, '').to_sym

        return @options[method] if args.empty?

        if method == :rails || args.first.is_a?(Hash)
          namespace, configuration = method, args.shift
        else
          namespace, configuration = args.shift, args.shift
          namespace = namespace.to_sym if namespace.respond_to?(:to_sym)
          @options[:rails][method] = namespace
        end

        if configuration
          aliases = configuration.delete(:aliases)
          @aliases[namespace].merge!(aliases) if aliases
          @options[namespace].merge!(configuration)
        end
      end
    end
  end
end
