#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport
  module NumberHelper
    class NumberToDelimitedConverter < NumberConverter #:nodoc:
      self.validate_float = true

      DELIMITED_REGEX = /(\d)(?=(\d\d\d)+(?!\d))/

      def convert
        parts.join(options[:separator])
      end

      private

        def parts
          left, right = number.to_s.split('.')
          left.gsub!(DELIMITED_REGEX) { "#{$1}#{options[:delimiter]}" }
          [left, right].compact
        end
    end
  end
end
