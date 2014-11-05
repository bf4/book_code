#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionController
  module Translation
    def translate(*args)
      I18n.translate *args
    end
    alias :t :translate

    def localize(*args)
      I18n.localize *args
    end
    alias :l :localize
  end
end