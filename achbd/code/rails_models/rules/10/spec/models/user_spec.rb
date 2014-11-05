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
    before(:each) do
      @zach = User.create!
      @david = User.create!
    end

    context "when the user is under their subscription limit" do
      before(:each) do
        @zach.subscription = Subscription.new
        @zach.subscription.stub(:can_send_message?).and_return true
      end
    
      it "creates a new message with the submitted attributes" do
        msg = @zach.send_message(
          :title => "Book Update", 
          :text => "Beta 11 includes great stuff!",
          :recipient => @david
        )
        msg.title.should == "Book Update"
        msg.text.should == "Beta 11 includes great stuff!"
      end

      it "sends a message to another user" do
        msg = @zach.send_message(
          :title => "Book Update", 
          :text => "Beta 11 includes great stuff!",
          :recipient => @david
        )
        @david.received_messages.should == [msg]
        msg.title.should == "Book Update"
        msg.text.should == "Beta 11 includes great stuff!"
      end
      
      it "adds the message to the sender's sent messages" do
        msg = @zach.send_message(
          :title => "Book Update", 
          :text => "Beta 11 includes great stuff!",
          :recipient => @david
        )
        @zach.sent_messages.should == [msg]      
      end
      
    end
    
    context "when the user is over their subscription limit" do
      before(:each) do
        @zach.subscription = Subscription.new
        @zach.subscription.stub(:can_send_message?).and_return false
      end
      
      it "does not create a message" do
        lambda { 
          @zach.send_message(
            :title => "Book Update", 
            :text => "Beta 11 includes great stuff!",
            :recipient => @david
          )
        }.should_not change(Message, :count)
      end
    end
    
  end

end
