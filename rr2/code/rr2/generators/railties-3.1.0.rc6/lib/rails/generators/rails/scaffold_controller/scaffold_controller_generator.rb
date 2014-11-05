#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'rails/generators/resource_helpers'

module Rails
  module Generators
    class ScaffoldControllerGenerator < NamedBase
      include ResourceHelpers

      check_class_collision :suffix => "Controller"

      class_option :orm, :banner => "NAME", :type => :string, :required => true,
                         :desc => "ORM to generate the controller for"

      def create_controller_files
        template 'controller.rb', File.join('app/controllers', class_path, "#{controller_file_name}_controller.rb")
      end

      hook_for :template_engine, :test_framework, :as => :scaffold

      # Invoke the helper using the controller name (pluralized)
      hook_for :helper, :as => :scaffold do |invoked|
        invoke invoked, [ controller_name ]
      end
    end
  end
end
