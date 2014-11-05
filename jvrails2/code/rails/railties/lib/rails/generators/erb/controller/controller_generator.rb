#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "rails/generators/erb"
module Erb
  module Generators
    class ControllerGenerator < Base
      argument :actions, type: :array,
        default: [], banner: "action action"

      def copy_view_files
        base_path = File.join("app/views", class_path, file_name)
        empty_directory base_path
        actions.each do |action|
          @action = action
          @path = File.join(base_path, filename_with_extensions(action))
          template filename_with_extensions(:view), @path
        end
      end
    end
  end
end
