#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'rspec/core'
require 'rspec/core/formatters/base_text_formatter'
require 'rspec/print_failures_eagerly/version'

# We disable line length because the labels cause lines to be too long
# but they do not render in the book so it causes no problems.
# rubocop:disable Metrics/LineLength
module RSpec
  module PrintFailuresEagerly
    class Formatter
      RSpec::Core::Formatters.register self, :example_failed 

      def initialize(output) 
        @output = output
        @last_failure_index = 0
      end

      def example_failed(notification) 
        @output.puts
        @output.puts notification.fully_formatted(@last_failure_index += 1) 
        @output.puts
      end
    end
    module SilenceDumpFailures
      def dump_failures(_notification)
      end

      RSpec::Core::Formatters::BaseTextFormatter.prepend(self)
    end
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    config.add_formatter RSpec::PrintFailuresEagerly::Formatter
  end
end
# rubocop:enable Metrics/LineLength
