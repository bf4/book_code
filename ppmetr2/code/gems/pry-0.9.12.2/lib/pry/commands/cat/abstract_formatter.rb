#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::Cat
    class AbstractFormatter
      include Pry::Helpers::CommandHelpers
      include Pry::Helpers::BaseHelpers

      private
      def decorate(content)
        content.code_type = code_type
        content.between(*between_lines).
          with_line_numbers(use_line_numbers?)
      end

      def code_type
        opts[:type] || :ruby
      end

      def use_line_numbers?
        opts.present?(:'line-numbers') || opts.present?(:ex)
      end

      def between_lines
        [opts[:start] || 1, opts[:end] || -1]
      end
    end
  end
end
