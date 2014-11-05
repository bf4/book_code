#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'spec_helper'

describe User do

  describe "#send_message" do
    
    context "when the user is under their subscription limit" do
    
      it "sends a message to another user" do
        zach = User.create!
        david = User.create!
        msg = zach.send_message(
          :title => "Book Update", 
          :text => "Beta 11 includes great stuff!",
          :recipient => david
        )
        david.received_messages.should == [msg]
      end
      
      it "adds the message to the sender's sent messages"
      
    end
    
  end

end
