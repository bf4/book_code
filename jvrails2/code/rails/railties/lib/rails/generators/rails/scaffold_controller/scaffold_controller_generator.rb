#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module Rails
  module Generators
    class ScaffoldControllerGenerator < NamedBase
      def create_controller_files
        template "controller.rb", File.join("app/controllers", class_path,
          "#{controller_file_name}_controller.rb")
      end
    end
  end
end