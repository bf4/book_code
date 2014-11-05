#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path(File.join(File.dirname(__FILE__), 'helper'))

class ResponseMiddlewareTest < Faraday::TestCase
  def setup
    @conn = Faraday.new do |b|
      b.response :raise_error
      b.adapter :test do |stub|
        stub.get('ok')        { [200, {'Content-Type' => 'text/html'}, '<body></body>'] }
        stub.get('not-found') { [404, {'X-Reason' => 'because'}, 'keep looking'] }
        stub.get('error')     { [500, {'X-Error' => 'bailout'}, 'fail'] }
      end
    end
  end

  class ResponseUpcaser < Faraday::Response::Middleware
    def parse(body)
      body.upcase
    end
  end

  def test_success
    assert_nothing_raised do
      @conn.get('ok')
    end
  end

  def test_raises_not_found
    error = assert_raises Faraday::Error::ResourceNotFound do
      @conn.get('not-found')
    end
    assert_equal 'the server responded with status 404', error.message
    assert_equal 'because', error.response[:headers]['X-Reason']
  end

  def test_raises_error
    error = assert_raises Faraday::Error::ClientError do
      @conn.get('error')
    end
    assert_equal 'the server responded with status 500', error.message
    assert_equal 'bailout', error.response[:headers]['X-Error']
  end

  def test_upcase
    @conn.builder.insert(0, ResponseUpcaser)
    assert_equal '<BODY></BODY>', @conn.get('ok').body
  end
end

class ResponseNoBodyMiddleWareTest < Faraday::TestCase
  def setup
    @conn = Faraday.new do |b|
      b.response :raise_error
      b.adapter :test do |stub|
        stub.get('not_modified') { [304, nil, nil] }
        stub.get('no_content') { [204, nil, nil] }
      end
    end
    @conn.builder.insert(0, NotCalled)
  end

  class NotCalled < Faraday::Response::Middleware
    def parse(body)
      raise "this should not be called"
    end
  end

  def test_204
    assert_equal nil, @conn.get('no_content').body
  end

  def test_304
    assert_equal nil, @conn.get('not_modified').body
  end
end
