#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionDispatch
  class BestStandardsSupport
    def initialize(app, type = true)
      @app = app

      @header = case type
      when true
        "IE=Edge,chrome=1"
      when :builtin
        "IE=Edge"
      when false
        nil
      end
    end

    def call(env)
      status, headers, body = @app.call(env)
      headers["X-UA-Compatible"] = @header
      [status, headers, body]
    end
  end
end
