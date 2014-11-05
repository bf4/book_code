#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require "rails/generators/named_base"

module Css
  module Generators
    class AssetsGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def copy_stylesheet
        copy_file "stylesheet.css", File.join('app/assets/stylesheets', class_path, "#{file_name}.css")
      end
    end
  end
end
