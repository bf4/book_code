#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class GatewayClient
  def initialize(network)
    @network = network
  end

  def connect
    3.times do
      return true if @connection = @network.open_connection
    end
    return false
  end
end

class Connection
end

describe GatewayClient, "#connect" do
  before(:each) do
    @network = stub()
    @gateway_client = GatewayClient.new(@network)
  end

  it "returns true if network returns connection on first attempt" do
    @network.should_receive(:open_connection).
      and_return(Connection.new) 
    @gateway_client.connect.should be_true
  end

  it "returns true if network returns connection on third attempt" do
    @network.should_receive(:open_connection).
      and_return(nil, nil, Connection.new) 
    @gateway_client.connect.should be_true
  end

  it "returns false if network fails to return connection in 3 attempts" do
    @network.should_receive(:open_connection).
      and_return(nil, nil, nil) 
    @gateway_client.connect.should be_false
  end

  it "returns false if network fails to return connection in 3 attempts" do
    @network.should_receive(:open_connection).
      exactly(3).times. 
      and_return(nil)
    @gateway_client.connect.should be_false
  end
end
