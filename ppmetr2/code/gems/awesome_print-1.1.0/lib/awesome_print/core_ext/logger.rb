#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Copyright (c) 2010-2012 Michael Dvorkin
#
# Awesome Print is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module AwesomePrint
  module Logger

    # Add ap method to logger
    #------------------------------------------------------------------------------
    def ap(object, level = nil)
      level ||= AwesomePrint.defaults[:log_level] if AwesomePrint.defaults
      level ||= :debug
      send level, object.ai
    end
  end
end

Logger.send(:include, AwesomePrint::Logger)
ActiveSupport::BufferedLogger.send(:include, AwesomePrint::Logger) if defined?(ActiveSupport::BufferedLogger)
