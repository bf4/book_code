#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'erb'
require 'drb/drb'

class ReminderWriter
  include ERB::Util

  def initialize(reminder)
    @reminder = reminder
    @erb = ERB.new(erb_src)
  end

  def erb_src
    <<EOS
<ul>
<% @reminder.to_a.each do |k, v| %>
<li><%= k %>: <%=h v %></li>
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

  writer = ReminderWriter.new(there)
  puts writer.to_html
end
main