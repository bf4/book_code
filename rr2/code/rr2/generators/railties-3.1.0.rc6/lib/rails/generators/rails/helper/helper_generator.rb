#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Rails
  module Generators
    class HelperGenerator < NamedBase
      check_class_collision :suffix => "Helper"

      def create_helper_files
        template 'helper.rb', File.join('app/helpers', class_path, "#{file_name}_helper.rb")
      end

      hook_for :test_framework
    end
  end
end
