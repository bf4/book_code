#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'rake'

module Rake

  # Base class for Task Libraries.
  class TaskLib
    include Cloneable
    include Rake::DSL

    # Make a symbol by pasting two strings together.
    #
    # NOTE: DEPRECATED! This method is kinda stupid. I don't know why
    # I didn't just use string interpolation. But now other task
    # libraries depend on this so I can't remove it without breaking
    # other people's code. So for now it stays for backwards
    # compatibility. BUT DON'T USE IT.
    def paste(a,b)              # :nodoc:
      (a.to_s + b.to_s).intern
    end
  end

end
