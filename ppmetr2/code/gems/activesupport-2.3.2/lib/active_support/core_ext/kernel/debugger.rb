#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Kernel
  unless respond_to?(:debugger)
    # Starts a debugging session if ruby-debug has been loaded (call script/server --debugger to do load it).
    def debugger
      Rails.logger.info "\n***** Debugger requested, but was not available: Start server with --debugger to enable *****\n"
    end
  end

  def breakpoint
    Rails.logger.info "\n***** The 'breakpoint' command has been renamed 'debugger' -- please change *****\n"
    debugger
  end
end
