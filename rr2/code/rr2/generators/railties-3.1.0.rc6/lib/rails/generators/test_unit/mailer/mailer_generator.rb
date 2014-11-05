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
    class MailerGenerator < Base
      argument :actions, :type => :array, :default => [], :banner => "method method"
      check_class_collision :suffix => "Test"

      def create_test_files
        template "functional_test.rb", File.join('test/functional', class_path, "#{file_name}_test.rb")
      end
    end
  end
end
