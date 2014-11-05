require 'rack/lint'

class HelloWorld
  def call(env)
    [200, {"Content-Type" => 'text/plain'}, ["Hello world!"]]
  end
end

use Rack::Lint
run HelloWorld.new
