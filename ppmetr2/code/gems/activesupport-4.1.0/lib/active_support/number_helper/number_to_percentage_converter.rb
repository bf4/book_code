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
    class NumberToPercentageConverter < NumberConverter # :nodoc:
      self.namespace = :percentage

      def convert
        rounded_number = NumberToRoundedConverter.convert(number, options)
        options[:format].gsub('%n', rounded_number)
      end
    end
  end
end
