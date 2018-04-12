#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class IOSHTTPAdapter

  attr_accessor :base_url

  def initialize(url)
    @base_url = url
  end

  def get(url, &block)
    http_client.get(url) do |result|
      block.call(result.object, result.error)
    end
  end

  def post(url, hash, &block)
    http_client.post(url, hash) do |result|
      block.call(result.object, result.error)
    end
  end

  def put(url, hash, &block)
    http_client.put(url, hash) do |result|
      block.call(result.object, result.error)
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

end
