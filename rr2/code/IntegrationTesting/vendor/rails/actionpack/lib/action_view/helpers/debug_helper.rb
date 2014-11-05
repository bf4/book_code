#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionView
  module Helpers
    # Provides a set of methods for making it easier to locate problems.
    module DebugHelper
      # Returns a <pre>-tag set with the +object+ dumped by YAML. Very readable way to inspect an object.
      def debug(object)
        begin
          Marshal::dump(object)
          "<pre class='debug_dump'>#{h(object.to_yaml).gsub("  ", "&nbsp; ")}</pre>"
        rescue Object => e
          # Object couldn't be dumped, perhaps because of singleton methods -- this is the fallback
          "<code class='debug_dump'>#{h(object.inspect)}</code>"
        end
      end
    end
  end
end