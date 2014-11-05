#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Rails
  module Generator
    class SimpleLogger # :nodoc:
      attr_reader :out
      attr_accessor :quiet

      def initialize(out = $stdout)
        @out = out
        @quiet = false
        @level = 0
      end

      def log(status, message, &block)
        @out.print("%12s  %s%s\n" % [status, '  ' * @level, message]) unless quiet
        indent(&block) if block_given?
      end

      def indent(&block)
        @level += 1
        if block_given?
          begin
            block.call
          ensure
            outdent
          end
        end
      end

      def outdent
        @level -= 1
        if block_given?
          begin
            block.call
          ensure
            indent
          end
        end
      end

      private
        def method_missing(method, *args, &block)
          log(method.to_s, args.first, &block)
        end
    end
  end
end
