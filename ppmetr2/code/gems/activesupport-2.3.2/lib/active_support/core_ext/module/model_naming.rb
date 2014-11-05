#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport
  class ModelName < String
    attr_reader :singular, :plural, :cache_key, :partial_path

    def initialize(name)
      super
      @singular = underscore.tr('/', '_').freeze
      @plural = @singular.pluralize.freeze
      @cache_key = tableize.freeze
      @partial_path = "#{@cache_key}/#{demodulize.underscore}".freeze
    end
  end

  module CoreExtensions
    module Module
      # Returns an ActiveSupport::ModelName object for module. It can be
      # used to retrieve all kinds of naming-related information.
      def model_name
        @model_name ||= ModelName.new(name)
      end
    end
  end
end
