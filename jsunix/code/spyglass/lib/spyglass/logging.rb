#---
# Excerpted from "Working with Unix Processes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsunix for more book information.
#---
module Spyglass
  module Logging
    def out(message)
      $stdout.puts preamble + message
    end

    def err(message)
      $stderr.puts preamble + message
    end

    def verbose(message)
      return unless Config.verbose
      out(message)
    end

    def vverbose(message)
      return unless Config.vverbose
      out(message)
    end

    def preamble
      "[#{Process.pid}] [#{self.class.name}] "
    end
  end
end
