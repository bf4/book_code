#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "rails/generators/named_base"

module Erb
  module Generators
    class Base < Rails::Generators::NamedBase
      protected
      def format
        :html
      end
      def handler
        :erb
      end
      def filename_with_extensions(name)
        [name, format, handler].compact.join(".")
      end
    end
  end
end