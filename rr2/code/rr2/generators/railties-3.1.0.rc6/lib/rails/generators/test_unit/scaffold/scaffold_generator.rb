#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'rails/generators/test_unit'
require 'rails/generators/resource_helpers'

module TestUnit
  module Generators
    class ScaffoldGenerator < Base
      include Rails::Generators::ResourceHelpers

      check_class_collision :suffix => "ControllerTest"

      def create_test_files
        template 'functional_test.rb',
                 File.join('test/functional', controller_class_path, "#{controller_file_name}_controller_test.rb")
      end
    end
  end
end
