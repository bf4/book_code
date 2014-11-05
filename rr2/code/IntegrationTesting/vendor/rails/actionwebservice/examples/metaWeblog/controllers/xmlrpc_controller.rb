#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
#
# example controller implementing both blogger and metaWeblog APIs
# in a way that should be compatible with clients supporting both/either.
#
# test by pointing your client at http://URL/xmlrpc/api
# 

require 'meta_weblog_service'
require 'blogger_service'

class XmlrpcController < ApplicationController
  web_service_dispatching_mode :layered

  web_service :metaWeblog, MetaWeblogService.new
  web_service :blogger, BloggerService.new
end
