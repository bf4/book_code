#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'service.rb'

class Expand1 < Service
  def process
    req = @ts.take([nil, nil, nil, Array, nil])
p req
    request(*req[3]) do |response|
p response
      req[3] = response.answer
      p req
      @ts.write(req)
    end
  end
end

Expand1.new.run
