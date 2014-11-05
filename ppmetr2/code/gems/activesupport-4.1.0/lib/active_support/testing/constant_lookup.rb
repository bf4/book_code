#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "active_support/concern"
require "active_support/inflector"

module ActiveSupport
  module Testing
    # Resolves a constant from a minitest spec name.
    #
    # Given the following spec-style test:
    #
    #   describe WidgetsController, :index do
    #     describe "authenticated user" do
    #       describe "returns widgets" do
    #         it "has a controller that exists" do
    #           assert_kind_of WidgetsController, @controller
    #         end
    #       end
    #     end
    #   end
    #
    # The test will have the following name:
    #
    #   "WidgetsController::index::authenticated user::returns widgets"
    #
    # The constant WidgetsController can be resolved from the name.
    # The following code will resolve the constant:
    #
    #   controller = determine_constant_from_test_name(name) do |constant|
    #     Class === constant && constant < ::ActionController::Metal
    #   end
    module ConstantLookup
      extend ::ActiveSupport::Concern

      module ClassMethods  # :nodoc:
        def determine_constant_from_test_name(test_name)
          names = test_name.split "::"
          while names.size > 0 do
            names.last.sub!(/Test$/, "")
            begin
              constant = names.join("::").constantize
              break(constant) if yield(constant)
            rescue NoMethodError # subclass of NameError
              raise
            rescue NameError
              # Constant wasn't found, move on
            ensure
              names.pop
            end
          end
        end
      end

    end
  end
end
