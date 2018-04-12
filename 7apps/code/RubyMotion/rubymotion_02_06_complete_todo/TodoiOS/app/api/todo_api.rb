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
    http_client.get("/todos") do |result|
      call_complete(result)
    end
  end

  def update_todo(todo)
    http_client.put("/todos/#{todo['id']}", todo) do |result|
      call_complete(result)
    end
  end

  def call_complete(result)
    if result.success?
      @listener_lambda.call(result.object)
    else
      @listener_lambda.call(nil, result.error)
    end
  end

  def http_client
    AFMotion::Client.build(base_url) do
      request_serializer :json
      header "Accept", "application/json"
      header "Content-Type", "application/json"
      response_serializer :json
    end
  end

  def base_url
    "http://localhost:3000"
  end

end
