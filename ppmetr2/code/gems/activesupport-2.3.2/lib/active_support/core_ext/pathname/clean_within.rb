#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Pathname #:nodoc:
      module CleanWithin
        # Clean the paths contained in the provided string.
        def clean_within(string)
          string.gsub(%r{[\w. ]+(/[\w. ]+)+(\.rb)?(\b|$)}) do |path|
            new(path).cleanpath
          end
        end
      end
    end
  end
end
