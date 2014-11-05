#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module VCR
  # Integrates VCR with RSpec.
  module RSpec
    # @private
    module Metadata
      extend self

      def configure!
        ::RSpec.configure do |config|
          vcr_cassette_name_for = lambda do |metadata|
            description = metadata[:description]

            if example_group = metadata[:example_group]
              [vcr_cassette_name_for[example_group], description].join('/')
            else
              description
            end
          end

          config.around(:each, :vcr => lambda { |v| !!v }) do |example|
            options = example.metadata[:vcr]
            options = options.is_a?(Hash) ? options.dup : {} # in case it's just :vcr => true

            cassette_name = options.delete(:cassette_name) ||
                            vcr_cassette_name_for[example.metadata]

            VCR.use_cassette(cassette_name, options, &example)
          end
        end
      end
    end
  end
end

