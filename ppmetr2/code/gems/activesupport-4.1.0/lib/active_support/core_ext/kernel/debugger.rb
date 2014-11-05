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
    # Starts a debugging session if the +debugger+ gem has been loaded (call rails server --debugger to do load it).
    def debugger
      message = "\n***** Debugger requested, but was not available (ensure the debugger gem is listed in Gemfile/installed as gem): Start server with --debugger to enable *****\n"
      defined?(Rails) ? Rails.logger.info(message) : $stderr.puts(message)
    end
    alias breakpoint debugger unless respond_to?(:breakpoint)
  end
end
