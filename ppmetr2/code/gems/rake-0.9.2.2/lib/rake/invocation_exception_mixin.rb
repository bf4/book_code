#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rake
  module InvocationExceptionMixin
    # Return the invocation chain (list of Rake tasks) that were in
    # effect when this exception was detected by rake.  May be null if
    # no tasks were active.
    def chain
      @rake_invocation_chain ||= nil
    end

    # Set the invocation chain in effect when this exception was
    # detected.
    def chain=(value)
      @rake_invocation_chain = value
    end
  end
end
