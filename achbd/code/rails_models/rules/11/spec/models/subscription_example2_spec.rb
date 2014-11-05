#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'spec_helper'

describe Subscription do
  
  describe "#can_send_message?" do
    context "when a user has not reached the subscription limit for the month" do
      it "returns true"
    end
    
    context "when a user has reached the subscription limit for the month" do
      it "returns false"
    end
  end
  
end
