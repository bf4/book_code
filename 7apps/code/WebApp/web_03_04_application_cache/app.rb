#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
require 'sinatra'

set :public_folder, File.dirname(__FILE__) + '/app'

get "/" do
  send_file "app/index.html"
end

get "/manifest.appcache" do
  send_file "app/manifest.appcache", :type => "text/cache-manifest"
end
