#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'rails/generators/resource_helpers'
require 'rails/generators/rails/model/model_generator'
require 'active_support/core_ext/object/blank'

module Rails
  module Generators
    class ResourceGenerator < ModelGenerator #metagenerator
      include ResourceHelpers

      hook_for :resource_controller, :required => true do |controller|
        invoke controller, [ controller_name, options[:actions] ]
      end

      class_option :actions, :type => :array, :banner => "ACTION ACTION", :default => [],
                             :desc => "Actions for the resource controller"

      def add_resource_route
        return if options[:actions].present?
        route_config =  regular_class_path.collect{|namespace| "namespace :#{namespace} do " }.join(" ")
        route_config << "resources :#{file_name.pluralize}"
        route_config << " end" * regular_class_path.size
        route route_config
      end
    end
  end
end
