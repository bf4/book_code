#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Dispatcher
  class <<self
    attr_accessor :time_to_sleep
    attr_accessor :raise_exception
    attr_accessor :dispatch_hook

    def dispatch(cgi, session_options = nil, output = $stdout)
      dispatch_hook.call(cgi) if dispatch_hook
      sleep(time_to_sleep || 0)
      raise raise_exception, "Something died" if raise_exception
    end
  end
end
