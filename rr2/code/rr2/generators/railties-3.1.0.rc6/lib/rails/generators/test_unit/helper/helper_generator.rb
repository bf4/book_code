#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'rails/generators/test_unit'

module TestUnit
  module Generators
    class HelperGenerator < Base
      check_class_collision :suffix => "HelperTest"

      def create_helper_files
        template 'helper_test.rb', File.join('test/unit/helpers', class_path, "#{file_name}_helper_test.rb")
      end
    end
  end
end
