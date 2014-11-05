#---
# Excerpted from "Seven Web Frameworks in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
#---
require_relative "app"
require "rspec"
require "rack/test"
require "json"

set :environment, :test

describe "Bookmarking App" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "returns a list of bookmarks" do
    get "/bookmarks"
    last_response.should be_ok
    bookmarks = JSON.parse(last_response.body)
    bookmarks.should be_instance_of(Array)
  end

  it "creates a new bookmark" do
    get "/bookmarks"
    bookmarks = JSON.parse(last_response.body)
    last_size = bookmarks.size

    post "/bookmarks",
      {:url => "http://www.test.com", :title => "Test"}.to_json
    last_response.status.should == 201
    response = JSON.parse(last_response.body)
    response['id'].should > 0

    get "/bookmarks"
    bookmarks = JSON.parse(last_response.body)
    expect(bookmarks.size).to eq(last_size + 1)
  end

  it "updates a bookmark" do
    url = "http://www.test.com"
    post "/bookmarks", {:url => url, :title => "Test"}.to_json
    get "/bookmarks"
    bookmarks = JSON.parse(last_response.body)

    bookmark = bookmarks.last
    id = bookmark['id']
    
    post "/bookmarks/#{id}",
      {:_method => "put", :url => url, :title => "Success"}.to_json
    last_response.status.should == 200

    get "/bookmarks/#{id}"
    retrieved_bookmark = JSON.parse(last_response.body)
    expect(retrieved_bookmark["title"]).to eq("Success")
  end

  it "deletes a bookmark" do
    post "/bookmarks",
      {:url => "http://www.test.com", :title => "Test"}.to_json
    get "/bookmarks"
    bookmarks = JSON.parse(last_response.body)
    last_size = bookmarks.size
    
    post "/bookmarks/#{bookmarks.last['id']}",
      {:_method => "delete"}
    last_response.status.should == 200

    get "/bookmarks"
    bookmarks = JSON.parse(last_response.body)
    expect(bookmarks.size).to eq(last_size - 1)
  end

  it "sends an error code for invalid get request" do
    get "/bookmarks/0"
    last_response.status.should == 404
  end

  it "sends an error code for invalid put request" do
    post "/bookmarks/0", {:_method => "put", :title => "Success"}.to_json
    last_response.status.should == 404
  end

  it "sends an error code for invalid delete request" do
    post "/bookmarks/0", {:_method => "delete"}
    last_response.status.should == 404
  end

  it "sends an error code for invalid create request" do
    post "/bookmarks", {:url => "test", :title => "Test"}.to_json
    last_response.status.should == 400
  end

  it "sends an error code for invalid update request" do
    get "/bookmarks"
    bookmarks = JSON.parse(last_response.body)
    id = bookmarks.first['id']

    post "/bookmarks/#{id}", {:_method => "put", :url => "Invalid"}.to_json
    last_response.status.should == 400
  end

  it "creates and updates a bookmark with tags" do
    post "/bookmarks",
      {:url => "http://www.test.com", :title => "Test",
       :tagList => ["One", "Two"]}.to_json
    last_response.status.should == 201
    bookmark = JSON.parse(last_response.body)
    new_id = bookmark['id']
    new_id.should > 0
    expect(bookmark["tagList"].size).to eq(2)
    expect(bookmark["tagList"][0]).to eq("One")
    expect(bookmark["tagList"][1]).to eq("Two")

    post "/bookmarks/#{bookmark["id"]}", {:_method => "put",
      :url => bookmark["url"], :title => bookmark["title"],
      :tagList => [" Four ","  Two "]}.to_json
    last_response.status.should == 200

    get "/bookmarks/#{bookmark["id"]}"
    bookmark = JSON.parse(last_response.body)
    expect(bookmark["tagList"].size).to eq(2)
    expect(bookmark["tagList"][0]).to eq("Four")
    expect(bookmark["tagList"][1]).to eq("Two")
  end

  it "filters bookmarks by tags" do
    post "/bookmarks",
      {:url => "http://www.test2.com", :title => "Test2",
       :tagList => ["Tag1","Tag2"]}.to_json

    post "/bookmarks",
      {:url => "http://www.test4.com", :title => "Test4",
       :tagList => ["Tag4","Tag1"]}.to_json

    get "/bookmarks/Tag1/Tag4"
    bookmarks = JSON.parse(last_response.body)
    bookmarks.size.should eq(1)
    bookmarks[0]["title"].should eq("Test4")

    get "/bookmarks/Tag1"
    bookmarks = JSON.parse(last_response.body)
    bookmarks.size.should eq(2)

    bookmarks.each do |bookmark|
      post "/bookmarks/#{bookmark['id']}", {:_method => "delete"}
      last_response.status.should == 200
    end
  end
end
