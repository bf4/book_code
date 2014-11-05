#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'spec_helper'

class TestCache < Hash
    def read(key)
      if cached = self[key]
        Marshal.load(cached)
      end
    end

    def write(key, data)
      self[key] = Marshal.dump(data)
    end

    def fetch(key)
      read(key) || yield.tap { |data| write(key, data) }
    end
  end
@cache = TestCache.new

describe Ghee::Connection do 
  context "with custom cache middleware" do 
    before :all do 
      @cache = TestCache.new
      @connection =  connection =  Ghee::Connection.new(GH_AUTH) do |conn|
                conn.use FaradayMiddleware::Caching, @cache
              end

      @ghee = Ghee.new(GH_AUTH) do |conn|
                conn.use FaradayMiddleware::Caching, @cache
      end
    end
    let( :connection ){@connection}
    let( :ghee ){@ghee}
    describe "authorization request" do 
      it "should make one request only" do
        VCR.use_cassette "cached auth" do
          connection.get("/").status.should == 200
        end
        # this will throw a cassette warning if
        # it makes another request
        connection.get("/").status.should == 200

      end
    end
    describe "with pagination" do 
      it "should retreive all the pages" do
        VCR.use_cassette "cached_gists" do
            gists = ghee.gists.all
            gists.size.should > 100
        end
        ghee.gists.all.size.should > 100
      end

    end
  end
end
