#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class AndroidHttpAdapter

  attr_accessor :base_url

  def initialize(url)
    @base_url = url
  end

  def get(url, &block)
    request = request_builder do |builder|
      builder.url "#{base_url}/#{url}"
    end
    response = execute_request request
    block.call(parse_array_response(response), nil)
  end

  def post(url, hash, &block)
    body = serializeHashToString hash
    request = request_builder do |builder|
      builder.url "#{base_url}/#{url}"
      builder.post(json_request(body))
    end
    response = execute_request request
    block.call(parse_object_response(response), nil)
  end

  def put(url, hash, &block)
    body = serializeHashToString hash
    request = request_builder do |builder|
      builder.url "#{base_url}/#{url}"
      builder.put(json_request(body))
    end
    block.call(execute_request(request), nil)
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

  def execute_request(request)
    client.newCall(request).execute
  end

  def json_request(body)
    Com::Squareup::Okhttp::RequestBody.create(
      json_media_type,
      body
    )
  end

  def parse_array_response(response)
    stream = response.body.charStream
    deserializeHashMapArray stream
  end

  def parse_object_response(response)
    stream = response.body.charStream
    gson = Com::Google::Gson::Gson.new
    gson.fromJson stream, Java::Util::HashMap
  end

  def json_media_type
    Com::Squareup::Okhttp::MediaType.parse("application/json")
  end

end
