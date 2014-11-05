#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'thread'
require 'monitor'

module ActiveSupport
  module Concurrency
    class Latch
      def initialize(count = 1)
        @count = count
        @lock = Monitor.new
        @cv = @lock.new_cond
      end

      def release
        @lock.synchronize do
          @count -= 1 if @count > 0
          @cv.broadcast if @count.zero?
        end
      end

      def await
        @lock.synchronize do
          @cv.wait_while { @count > 0 }
        end
      end
    end
  end
end
