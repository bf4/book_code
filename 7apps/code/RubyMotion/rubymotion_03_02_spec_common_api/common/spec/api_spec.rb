#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
require 'minitest/autorun'
require 'minitest/mock'
require 'api/todo_api'

DUMMY_URL = "dummy://url"

describe TodoApi do

  before do
    @mock_client = MiniTest::Mock.new
    @mock_client.expect :new, @mock_client, [DUMMY_URL]

    TodoApi.client_class  = @mock_client
    TodoApi.base_url      = DUMMY_URL
  end

  it "should perform a GET /todos through a given client" do
    @mock_client.expect :get, nil do |url, &block|
      url == "/todos" && block.nil? == false
    end

    TodoApi.new(nil).get_all_todos
    @mock_client.verify.must_equal true
  end

  it "should perform a POST /todos through a given client" do
    title = "New Todo"
    @mock_client.expect :post, nil do |url, todo_hash, &block|
      url == "/todos" &&
      todo_hash[:title].nil? == false &&
      todo_hash[:title] == title &&
      block.nil? == false
    end

    TodoApi.new(nil).create_todo(title)
    @mock_client.verify.must_equal true
  end

  it "should perform a PUT /todos through a given client" do
    todo = {
      'id' => 42
    }

    @mock_client.expect :put, nil do |url, todo_hash, &block|
      url == "/todos/42" && block.nil? == false
    end

    TodoApi.new(nil).update_todo(todo)
    @mock_client.verify.must_equal true
  end
end
