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
    module DomAssertions
      # Test two HTML strings for equivalency (e.g., identical up to reordering of attributes)
      #
      # ==== Examples
      #
      #   # assert that the referenced method generates the appropriate HTML string
      #   assert_dom_equal '<a href="http://www.example.com">Apples</a>', link_to("Apples", "http://www.example.com")
      #
      def assert_dom_equal(expected, actual, message = "")
        clean_backtrace do
          expected_dom = HTML::Document.new(expected).root
          actual_dom   = HTML::Document.new(actual).root
          full_message = build_message(message, "<?> expected to be == to\n<?>.", expected_dom.to_s, actual_dom.to_s)

          assert_block(full_message) { expected_dom == actual_dom }
        end
      end
      
      # The negated form of +assert_dom_equivalent+.
      #
      # ==== Examples
      #
      #   # assert that the referenced method does not generate the specified HTML string
      #   assert_dom_not_equal '<a href="http://www.example.com">Apples</a>', link_to("Oranges", "http://www.example.com")
      #
      def assert_dom_not_equal(expected, actual, message = "")
        clean_backtrace do
          expected_dom = HTML::Document.new(expected).root
          actual_dom   = HTML::Document.new(actual).root
          full_message = build_message(message, "<?> expected to be != to\n<?>.", expected_dom.to_s, actual_dom.to_s)

          assert_block(full_message) { expected_dom != actual_dom }
        end
      end
    end
  end
end
