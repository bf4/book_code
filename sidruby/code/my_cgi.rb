#!/usr/local/bin/ruby
#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'webrick/cgi'
require 'erb'

class MyCGI < WEBrick::CGI
  def initialize(*args)
    super(*args)
    @erb = create_erb
  end

  def do_GET(req, res)
    build_page(req, res)
  rescue
    error_page(req, res)
  end

  def build_page(req, res)
    res["content-type"] = "text/html"
    res.body = @erb.result(binding)
  end

  def error_page(req, res)
    res["content-type"] = "text/plain"
    res.body = 'oops'
  end

  def create_erb
    ERB.new(<<EOS)
<html>
 <head><title>Hello</title></head>
 <body>Hello, World.</body>
</html>
EOS
  end
end

MyCGI.new.start()
