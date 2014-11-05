#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Range #:nodoc:
      # Getting ranges in different convenient string representations and other objects
      module Conversions
        RANGE_FORMATS = {
          :db => Proc.new { |start, stop| "BETWEEN '#{start.to_s(:db)}' AND '#{stop.to_s(:db)}'" }
        }

        def self.included(base) #:nodoc:
          base.class_eval do
            alias_method :to_default_s, :to_s
            alias_method :to_s, :to_formatted_s
          end
        end
        # Gives a human readable format of the range.
        #
        # ==== Example
        # 
        #   [1..100].to_formatted_s # => "1..100"
        def to_formatted_s(format = :default)
          RANGE_FORMATS[format] ? RANGE_FORMATS[format].call(first, last) : to_default_s
        end
      end
    end
  end
end
