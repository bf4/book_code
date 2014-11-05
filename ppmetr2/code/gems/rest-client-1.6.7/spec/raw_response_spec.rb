#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.join( File.dirname(File.expand_path(__FILE__)), 'base')

describe RestClient::RawResponse do
  before do
    @tf = mock("Tempfile", :read => "the answer is 42", :open => true)
    @net_http_res = mock('net http response')
    @response = RestClient::RawResponse.new(@tf, @net_http_res, {})
  end

  it "behaves like string" do
    @response.to_s.should == 'the answer is 42'
  end

  it "exposes a Tempfile" do
    @response.file.should == @tf
  end
end
