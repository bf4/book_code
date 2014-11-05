#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'erb'

module VCR
  class Cassette
    # @private
    class ERBRenderer
      def initialize(raw_template, erb, cassette_name=nil)
        @raw_template, @erb, @cassette_name = raw_template, erb, cassette_name
      end

      def render
        return @raw_template if @raw_template.nil? || !use_erb?
        binding = binding_for_variables if erb_variables
        template.result(binding)
      rescue NameError => e
        handle_name_error(e)
      end

    private

      def handle_name_error(e)
        example_hash = (erb_variables || {}).merge(e.name => 'some value')

        raise Errors::MissingERBVariableError.new(
          "The ERB in the #{@cassette_name} cassette file references undefined variable #{e.name}.  " +
          "Pass it to the cassette using :erb => #{ example_hash.inspect }."
        )
      end

      def use_erb?
        !!@erb
      end

      def erb_variables
        @erb if @erb.is_a?(Hash)
      end

      def template
        @template ||= ERB.new(@raw_template)
      end

      @@struct_cache = Hash.new do |hash, attributes|
        hash[attributes] = Struct.new(*attributes)
      end

      def variables_object
        @variables_object ||= @@struct_cache[erb_variables.keys].new(*erb_variables.values)
      end

      def binding_for_variables
        @binding_for_variables ||= variables_object.instance_eval { binding }
      end
    end
  end
end
