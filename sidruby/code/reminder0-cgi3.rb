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

class ReminderWriter
  include ERB::Util

  def initialize(reminder)
    @reminder = reminder
    @erb = ERB.new(erb_src)
    @bg = BGColor.new
  end

  def script_name(cgi)
    cgi.script_name
  end

  def erb_src
    <<EOS
<form action="<%=script_name(cgi)%>" method="post">
<table border="0" cellspacing="0">
<% @reminder.to_a.each do |k, v| %>
<tr <%= @bg %>><td><%= k %></td><td><%=h v %></td></tr>
<% end %>
<tr <%= @bg %>>
<td><input type="submit" value="add" /></td>
<td><input type="text" name="item" value="" size="30" /></td>
</tr>
</table>
</form>
EOS
  end

  def to_html(cgi)
    @erb.result(binding)
  end
end

def kconv(str)
  NKF.nkf('-edXm0', str.to_s)
end

def do_request(cgi, reminder)
  item ,= cgi['item']
  return if item.nil? || item.empty?
  reminder.add(kconv(item))
end

def main 
  DRb.start_service
  there = DRbObject.new_with_uri('druby://localhost:12345')
  writer = ReminderWriter.new(there)

  cgi = CGI.new('html3')
  do_request(cgi, there)

  cgi.out({"charset"=>"euc-jp"}) {
    cgi.html {
      cgi.head { 
        cgi.title { 'Reminder' }
      } + cgi.body { writer.to_html(cgi) }
    }
  }
end

main