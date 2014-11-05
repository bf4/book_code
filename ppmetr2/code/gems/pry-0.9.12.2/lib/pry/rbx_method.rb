#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  module RbxMethod
    private

    def core_code
      MethodSource.source_helper(source_location)
    end

    def core_doc
      MethodSource.comment_helper(source_location)
    end
  end
end
