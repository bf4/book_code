#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'json'

class RubyDocServer
  def initialize(output: $stdout)
    @output = output
  end

  def process_request(path)
    class_name, method_prefix = path.sub(%r{^/}, '').split('/')
    klass = Object.const_get(class_name)
    methods = klass.instance_methods.grep(/\A#{method_prefix}/).sort
    respond_with(methods)
  end

private

  def respond_with(data)
    @output.puts 'Content-Type: application/json'
    @output.puts
    @output.puts JSON.generate(data)
  end
end

if __FILE__.end_with?($PROGRAM_NAME)
  RubyDocServer.new.process_request(ENV['PATH_INFO'])
end
