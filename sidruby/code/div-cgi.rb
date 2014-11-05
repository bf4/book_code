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
require 'tofu/cgicontext'
require 'tofu/proxy'

cgi = CGI.new

DRb.start_service
context = Tofu::CGIContext.new(cgi)
bartender = DRbObject.new(nil, 'druby://localhost:12345')
bartender.service(Tofu::ContextProxy.new(context))