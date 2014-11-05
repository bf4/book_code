#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'benchmark'

module ActionView
  module Helpers
    module BenchmarkHelper
      # Measures the execution time of a block in a template and reports the result to the log. Example:
      #
      #  <% benchmark "Notes section" do %>
      #    <%= expensive_notes_operation %>
      #  <% end %>
      #
      # Will add something like "Notes section (0.34523)" to the log.
      #
      # You may give an optional logger level as the second argument
      # (:debug, :info, :warn, :error).  The default is :info.
      def benchmark(message = "Benchmarking", level = :info)
        if @logger
          real = Benchmark.realtime { yield }
          @logger.send level, "#{message} (#{'%.5f' % real})"
        end
      end
    end
  end
end
