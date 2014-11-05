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

erb_src = <<EOS
<ul>
<% there.to_a.each do |k, v| %>
<li><%= k %>: <%= v %></li>
<% end %>
</ul>
EOS

DRb.start_service
there = DRbObject.new_with_uri('druby://localhost:12345')
ERB.new(erb_src).run