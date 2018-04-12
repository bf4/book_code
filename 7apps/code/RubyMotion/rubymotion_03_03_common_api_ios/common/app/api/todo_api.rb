#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class TodoApi

  def initialize(listener_lambda)
    @listener_lambda = listener_lambda
  end

  def get_all_todos
    http_client.get("/todos") do |result, error|
      @listener_lambda.call result, error
    end
  end

  def update_todo(todo)
    http_client.put("/todos/#{todo['id']}", todo) do |result, error|
      @listener_lambda.call result, error
    end
  end

  def create_todo(title)
    todo = {
      title: title
    }
    http_client.post("/todos", todo) do |result, error|
      @listener_lambda.call result, error
    end
  end

  def http_client
    @@client_class.new @@base_url
  end

  def self.client_class=(klass)
    @@client_class = klass
  end

  def self.base_url=(url)
    @@base_url = url
  end

end
