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
    class ControllerGenerator < NamedBase
      argument :actions, :type => :array, :default => [], :banner => "action action"
      check_class_collision :suffix => "Controller"

      def create_controller_files
        template 'controller.rb', File.join('app/controllers', class_path, "#{file_name}_controller.rb")
      end

      def add_routes
        actions.reverse.each do |action|
          route %{get "#{file_name}/#{action}"}
        end
      end

      hook_for :template_engine, :test_framework, :helper, :assets
    end
  end
end
