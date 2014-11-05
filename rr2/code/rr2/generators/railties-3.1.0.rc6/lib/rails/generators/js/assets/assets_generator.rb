#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require "rails/generators/named_base"

module Js
  module Generators
    class AssetsGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def copy_javascript
        copy_file "javascript.js", File.join('app/assets/javascripts', class_path, "#{file_name}.js")
      end
    end
  end
end
