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

describe "http_request_handler examples" do
  class RequestParameters < Hash
    def initialize(path)
      # self[:id] = "3"
    end
  end
  
  it "should parse a single query parameter (ex1)" do
    request_parameters = RequestParameters.new("/path/to/file?id=3")
    request_parameters.has_key?(:id).should == true
  end
  
  it "should parse a single query parameter (ex2)" do
    request_parameters = RequestParameters.new("/path/to/file?id=3")
    request_parameters.should have_key(:id)
  end
end
