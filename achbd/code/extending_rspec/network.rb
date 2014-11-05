#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'ping'

RSpec.configure do |c|
  c.exclusion_filter = {
    :if => lambda {|what| 
      case what
      when :network_available
        !Ping.pingecho "example.com", 10, 80
      end
    }
  }
end

describe "network group" do
  it "example 1", :if => :network_available do
  end
  it "example 2" do
  end
end
