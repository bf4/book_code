#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
if Rails.version =~ /^5/
  module ActionController 
    module ImplicitRender 
      # Current implementation doesn't work
      def default_render(*args) 
        render(*args) 
      end 
    end 
  end
end
