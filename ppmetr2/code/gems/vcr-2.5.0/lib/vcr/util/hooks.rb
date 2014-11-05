#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'vcr/util/variable_args_block_caller'

module VCR
  # @private
  module Hooks
    include VariableArgsBlockCaller

    FilteredHook = Struct.new(:hook, :filters) do
      include VariableArgsBlockCaller

      def conditionally_invoke(*args)
        filters = Array(self.filters)
        return if filters.any? { |f| !call_block(f.to_proc, *args) }
        call_block(hook, *args)
      end
    end

    def self.included(klass)
      klass.class_eval do
        extend ClassMethods
        hooks_module = Module.new
        const_set("DefinedHooks", hooks_module)
        include hooks_module
      end
    end

    def invoke_hook(hook_type, *args)
      hooks[hook_type].map do |hook|
        hook.conditionally_invoke(*args)
      end
    end

    def clear_hooks
      hooks.clear
    end

    def hooks
      @hooks ||= Hash.new do |hash, hook_type|
        hash[hook_type] = []
      end
    end

    def has_hooks_for?(hook_type)
      hooks[hook_type].any?
    end

    # @private
    module ClassMethods
      def define_hook(hook_type, prepend = false)
        placement_method = prepend ? :unshift : :<<

        # Put the hook methods in a module so we can override and super to these methods.
        self::DefinedHooks.module_eval do
          define_method hook_type do |*filters, &hook|
            hooks[hook_type].send(placement_method, FilteredHook.new(hook, filters))
          end
        end
      end
    end
  end
end
