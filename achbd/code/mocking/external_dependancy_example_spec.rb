#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'external_dependancy_example'

describe "Managing external dependancies" do

  before(:each) do
    @mock_db = mock('db')
    @mock_network = mock('network')
    @target = ExternalDependancyExample.new(@mock_db, @mock_network)
  end
  
  it "should send" do
    @mock_db.should_receive(:load).once.with(1).and_return('test')
    @mock_network.should_receive(:transmit).once.with('test')
    @target.send(1)
  end

  it "should receive" do
    @mock_network.should_receive(:receive).once.and_return('test')
    @mock_db.should_receive(:store).once.with(1, 'test')
    @target.receive(1)
  end

end