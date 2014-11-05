#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
class LiveAssetsController < ActionController::Base
  include ActionController::Live
  
  def hello
    while true
      response.stream.write "Hello World\n"
      sleep 1
    end
  rescue IOError
    response.stream.close
  end

  def sse
    response.headers["Cache-Control"] = "no-cache"
    response.headers["Content-Type"]  = "text/event-stream"

    sse = LiveAssets::SSESubscriber.new
    sse.each { |msg| response.stream.write msg }
  rescue IOError
    sse.close
    response.stream.close
  end
end
