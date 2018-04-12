#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class TodoApi

  def get_all_todos
    request = request_builder do |builder|
      builder.url base_url
    end
    response = execute_request request
    parse_array_response response
  end

  def create_todo(title)
    request_body = form_body_builder do |form_builder|
      form_builder.add "todo[title]", title
    end
    request = request_builder do |builder|
      builder.url base_url
      builder.post request_body
    end
    response = execute_request request
    parse_object_response response
  end

  def update_todo(todo)
    request_body = form_body_builder do |form_builder|
      form_builder.add "todo[title]", todo["title"]
      form_builder.add "todo[complete]", todo["complete"]
    end
    request = request_builder do |builder|
      builder.url "#{base_url}/#{todo['id'].to_i}"
      builder.put request_body
    end
    execute_request request
  end

  def base_url
    # Emulator: url = "http://10.0.2.2:3000/todos.json"
    # Genymotion url = "http://10.0.3.2:3000/todos.json"
    "http://10.0.2.2:3000/todos"
  end

  def client
    Com::Squareup::Okhttp::OkHttpClient.new
  end

  def request_builder
    builder = Com::Squareup::Okhttp::Request::Builder.new
    builder.header "Content-Type", "application/json"
    builder.header "Accept", "application/json"
    yield builder
    builder.build
  end

  def form_body_builder
    builder = Com::Squareup::Okhttp::FormEncodingBuilder.new
    yield builder
    builder.build
  end

  def execute_request(request)
    client.newCall(request).execute()
  end

  def parse_array_response(response)
    stream = response.body.charStream
    deserializeTodoArray stream
  end

  def parse_object_response(response)
    stream = response.body.charStream
    gson = Com::Google::Gson::Gson.new
    gson.fromJson(stream, Java::Util::HashMap)
  end

end

