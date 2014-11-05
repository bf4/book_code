#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'spec_helper'

describe Ghee::Connection do
  context "with an access_token" do
    subject { Ghee::Connection.new(GH_AUTH) }

    describe "#initialize" do
      it "should set an instance variable for access token" do
        subject.hash.should == GH_AUTH
      end
    end

    describe "any request" do
      let(:response) do
        VCR.use_cassette('authorized_request') do
          subject.get('/')
        end
      end

      it "should return 200" do
        response.status.should == 200
      end

      it "should parse the json response" do
        response.body.should_not be_nil
      end
    end
  end

  context "without an access token" do
    subject { Ghee::Connection.new }

    describe "#initialize" do
      it "should set an instance variable for access token" do
        subject.hash.should == {}
      end
    end

    describe "any request" do
      let(:response) do
        VCR.use_cassette('unauthorized_request') do
          subject.get('/')
        end
      end
      it "should return 200" do
        response.status.should == 200
      end

      it "should parse the json response" do
        response.body.should_not be_nil
      end
    end
  end
end
