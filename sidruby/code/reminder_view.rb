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
require 'drb/drb'

class ReminderView
  include ERB::Util

  def self.create_erb
    ERB.new(<<EOS)
<html><head><title>Reminder</title></head>
<body>
<ul>
<% @db.to_a.each do |k, v| %>
<li><%=h k %>: <%=h v %></li>
<% end %>
</ul>
</body>
</html>
EOS
  end

  extend ERB::DefMethod
  def_erb_method('to_html(req, res)', create_erb)

  def initialize(db)
    @db = db
  end
end

class ReminderCGI < WEBrick::CGI
  def initialize(db, *args)
    super(*args)
    @db = db
    @view = ReminderView.new(@db)
  end

  def do_GET(req, res)
    build_page(req, res)
  rescue
    error_page(req, res)
  end
  alias :do_POST :do_GET

  def build_page(req, res)
    res["content-type"] = "text/html; charset=utf-8"
    res.body = @view.to_html(req, res)
  end

  def error_page(req, res)
    res["content-type"] = "text/plain"
    res.body = 'oops'
  end
end

if __FILE__ == $0
  reminder = DRbObject.new_with_uri('druby://localhost:12345')
  ReminderCGI.new(reminder).start()
end
