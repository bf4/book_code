#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport
  module Testing
    # Logs a "PostsControllerTest: test name" heading before each test to
    # make test.log easier to search and follow along with.
    module TaggedLogging #:nodoc:
      attr_writer :tagged_logger

      def before_setup
        if tagged_logger
          heading = "#{self.class}: #{name}"
          divider = '-' * heading.size
          tagged_logger.info divider
          tagged_logger.info heading
          tagged_logger.info divider
        end
        super
      end

      private
        def tagged_logger
          @tagged_logger ||= (defined?(Rails.logger) && Rails.logger)
        end
    end
  end
end
