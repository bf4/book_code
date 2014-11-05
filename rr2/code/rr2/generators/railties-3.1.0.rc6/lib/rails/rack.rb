#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Rails
  module Rack
    autoload :ContentLength, "rails/rack/content_length"
    autoload :Debugger,      "rails/rack/debugger"
    autoload :Logger,        "rails/rack/logger"
    autoload :LogTailer,     "rails/rack/log_tailer"
  end
end
