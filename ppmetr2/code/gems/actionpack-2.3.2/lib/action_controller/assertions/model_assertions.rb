#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionController
  module Assertions
    module ModelAssertions
      # Ensures that the passed record is valid by Active Record standards and
      # returns any error messages if it is not.
      #
      # ==== Examples
      #
      #   # assert that a newly created record is valid
      #   model = Model.new
      #   assert_valid(model)
      #
      def assert_valid(record)
        ::ActiveSupport::Deprecation.warn("assert_valid is deprecated. Use assert record.valid? instead", caller)
        clean_backtrace do
          assert record.valid?, record.errors.full_messages.join("\n")
        end
      end
    end
  end
end
