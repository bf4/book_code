#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module String #:nodoc:
      # Additional string tests.
      module StartsEndsWith
        # Does the string start with the specified +prefix+?
        def starts_with?(prefix)
          prefix = prefix.to_s
          self[0, prefix.length] == prefix
        end

        # Does the string end with the specified +suffix+?
        def ends_with?(suffix)
          suffix = suffix.to_s
          self[-suffix.length, suffix.length] == suffix      
        end
      end
    end
  end
end
