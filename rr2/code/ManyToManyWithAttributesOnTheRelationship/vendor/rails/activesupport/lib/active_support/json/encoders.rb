#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActiveSupport
  module JSON #:nodoc:
    module Encoders
      mattr_accessor :encoders
      @@encoders = {}

      class << self        
        def define_encoder(klass, &block)
          encoders[klass] = block
        end
        
        def [](klass)
          klass.ancestors.each do |k|
            encoder = encoders[k]
            return encoder if encoder
          end
        end
      end
    end
  end
end

Dir[File.dirname(__FILE__) + '/encoders/*.rb'].each do |file|
  require file[0..-4]
end
