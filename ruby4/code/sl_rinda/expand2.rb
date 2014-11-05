#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'service.rb'

class Expand2 < Service
  def process
    req = @ts.take([nil, nil, nil, nil, Array])
    request(*req[4]) do |response|
      req[4] = response.answer
      @ts.write(req)
    end
  end
end

Expand2.new.run
