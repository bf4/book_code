#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'rubygems'
require 'spec'

class Bill
  def to_text
    <<-EOF
From: MegaCorp
To: Bob
Ref: 9887386
Note: We want our money!
EOF
  end
end

describe Bill do
  it "should print the bill" do
    bill = Bill.new
    bill.to_text.should == <<-EOF
From: MegaCorp
To: Bob Doe
Ref: 9887386
Note: Please pay imminently
EOF
  end
end