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
    class ScaffoldGenerator < Rails::Generators::NamedBase
      # In order to allow the Sass generators to pick up the default Rails CSS and
      # transform it, we leave it in a standard location for the CSS stylesheet
      # generators to handle. For the simple, default case, just copy it over.
      def copy_stylesheet
        dir = Rails::Generators::ScaffoldGenerator.source_root
        file = File.join(dir, "scaffold.css")
        create_file "app/assets/stylesheets/scaffold.css", File.read(file)
      end
    end
  end
end
