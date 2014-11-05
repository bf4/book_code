#!/usr/local/bin/ruby
#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'cgi'
require 'erb'
require 'drb/drb'
require 'nkf'

$KCODE='euc'

class BGColor
  def initialize
    @colors = ['#eeeeff', '#bbbbff']
    @count = -1
  end
  attr_accessor :colors

  def next_bgcolor
    @count += 1
    @count = 0 if @colors.size <= @count
    "bgcolor='#{@colors[@count]}'"
  end

  alias :to_s :next_bgcolor
end

class ReminderCGI
  include ERB::Util

  def initialize(reminder)
    @reminder = reminder
    @erb = ERB.new(erb_src)
    @bg = BGColor.new
  end

  def script_name(cgi)
    cgi.script_name
  end

  def make_param(hash)
    hash.collect do |k, v|
      u(k) + '=' + u(v)
    end.join(';')
  end

  def anchor(cgi, hash)
    %Q+<a href="#{script_name(cgi)}?#{make_param(hash)}">+
  end
  alias :a :anchor
  def a_delete(cgi, key)
    anchor(cgi, {'cmd'=>'delete', 'key'=>key})
  end
  def erb_src
    <<EOS
<table border="0" cellspacing="0">
<% @reminder.to_a.each do |k, v| %>
<tr <%= @bg %>>
 <td><%= k %></td>
 <td><%=h v %></td>
 <td>[<%=a_delete(cgi, k)%>X</a>]</td>
</tr>
<% end %>
<form action="<%=script_name(cgi)%>" method="post">
 <input type="hidden" name="cmd" value="add" />
 <tr <%= @bg %>>
 <td><input type="submit" value="add" /></td>
 <td><input type="text" name="item" value="" size="30" /></td>
 <td>&nbsp;</td>
 </tr>
</form>
</table>
EOS
  end

  def to_html(cgi)
    @erb.result(binding)
  rescue DRb::DRbConnError
    %Q+<p>It seems that the reminder server is downed.</p>+
  end

  def kconv(str)
    NKF.nkf('-edXm0', str.to_s)
  end

  def do_add(cgi)
    item ,= cgi['item']
    return if item.nil? || item.empty?
    @reminder.add(kconv(item))
  end

  def do_delete(cgi)
    key ,= cgi['key']
    return if key.nil? || key.empty?
    @reminder.delete(key.to_i)
  end

  def do_request(cgi)
    cmd ,= cgi['cmd']
    case cmd.to_s
    when 'add'
      do_add(cgi)
    when 'delete'
      do_delete(cgi)
    end
  end
end

class UnknownErrorPage
  include ERB::Util

  def initialize(error=$!, info=$@)
    @erb = ERB.new(erb_src)
    @error = error
    @info = info
  end

  def erb_src
    <<EOS
<p><%=h @error%> - <%=h @error.class%></p>
<ul>
<% @info.each do |line| %>
<li><%=h line%></li>
<% end %>
</ul>
EOS
  end

  def to_html
    @erb.result(binding)
  end
end

def main 
  DRb.start_service
  there = DRbObject.new_with_uri('druby://localhost:12345')
  reminder = ReminderCGI.new(there)

  cgi = CGI.new('html3')
  reminder.do_request(cgi)

  begin
    content = reminder.to_html(cgi)
  rescue
    content = UnknownErrorPage.new($!, $@).to_html
  end

  cgi.out({"charset"=>"euc-jp"}) {
    cgi.html {
      cgi.head { 
        cgi.title { 'Reminder' }
      } + cgi.body { content }
    }
  }
end

main