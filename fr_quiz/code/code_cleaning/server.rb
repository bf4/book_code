#!/usr/bin/env ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
require "webrick"

server = WEBrick::HTTPServer.new(:Port => 8080, :DocumentRoot => "cgi-bin")

['INT', 'TERM'].each do |signal|
  trap(signal) { server.shutdown }
end
server.start
