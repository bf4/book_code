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

  def erb_src
    <<EOS
<table border="0" cellspacing="0">
<% @reminder.to_a.each do |k, v| %>
<tr <%= @bg %>><td><%= k %></td><td><%=h v %></td></tr>
<% end %>
</table>
EOS
  end

  def to_html
    @erb.result(binding)
  end
end

def main 
  DRb.start_service
  there = DRbObject.new_with_uri('druby://localhost:12345')
  writer = ReminderWriter.new(there)

  cgi = CGI.new('html3')

  cgi.out({"charset"=>"euc-jp"}) {
    cgi.html {
      cgi.head { 
        cgi.title { 'Reminder' }
      } + cgi.body { writer.to_html }
    }
  }
end

main