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
    class ObserverGenerator < Base
      check_class_collision :suffix => "ObserverTest"

      def create_test_files
        template 'unit_test.rb',  File.join('test/unit', class_path, "#{file_name}_observer_test.rb")
      end
    end
  end
end
