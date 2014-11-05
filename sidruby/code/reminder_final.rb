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

class BGColor
  def initialize
    @colors = ['#eeeeff', '#bbbbff']
    @count = -1
  end

  def next_bgcolor
    @count += 1
    @count = 0 if @colors.size <= @count
    "bgcolor='#{@colors[@count]}'"
  end
  alias :to_s :next_bgcolor
end

class ReminderView
  include ERB::Util

  def self.create_erb
    ERB.new(<<EOS)
<html><head><title>Reminder</title></head>
<body>
<form method='post'>
<table>
<% bg = bg_color
   @db.to_a.each do |k, v| %>
<tr <%= bg %>>
  <td><%= k %></td>
  <td><%=h v %></td>
  <td><%=a_delete(k)%>X</a><td>
</tr>
<% end %>
<tr <%= bg %>>
<td><input type="submit" name="cmd" value="add" /></td>
<td><input type="text" name="item" value="" size="30" /></td>
</tr>
</table>
</form>
</body>
</html>
EOS
  end

  extend ERB::DefMethod
  def_erb_method('to_html(req, res)', create_erb)

  def initialize(db)
    @db = db
  end

  def bg_color
    BGColor.new
  end

  def make_param(hash)
    hash.collect do |k, v|
      u(k) + '=' + u(v)
    end.join(';')
  end

  def anchor(query)
    %Q+<a href="?#{make_param(query)}">+
  end

  def a_delete(key)
    anchor('cmd' => 'delete', 'key'=>key)
  end
end

class ReminderCGI < WEBrick::CGI
  def initialize(db, *args)
    super(*args)
    @db = db
    @view = ReminderView.new(@db)
  end

  def do_GET(req, res)
    do_request(req, res)
    build_page(req, res)
  rescue
    error_page(req, res)
  end
  alias :do_POST :do_GET

  def do_request(req, res)
    cmd ,= req.query['cmd']
    case cmd
    when 'add'
      do_add(req, res)
    when 'delete'
      do_delete(req, res)
    end
  end

  def do_add(req, res)
    item ,= req.query['item']
    return if item.nil? || item.empty?
    item.encode('utf-8')
    return unless item.valid_encoding?
    @db.add(item)
  end

  def do_delete(req, res)
    key ,= req.query['key']
    return if key.nil? || key.empty?
    @db.delete(key.to_i)
  end

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
