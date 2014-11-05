#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'spec_helper'

describe Message do
  it "is valid with valid attributes" do
    Message.new(:title => "foo").should be_valid
  end

  it "is not valid without a title" do
    message = Message.new :title => nil
    message.should_not be_valid
  end

  it "is not valid without text" do
    message = Message.new :text => nil
    message.should_not be_valid
  end

  it "is not valid without a recipient"
end
