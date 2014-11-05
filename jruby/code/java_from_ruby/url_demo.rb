#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'
java_import java.net.URL
java_import 'URLDemo'

def add_url_to_some_ruby_list(url)
end

url = URL.new 'http://pragprog.com/titles'

add_url_to_some_ruby_list(url)

URLDemo.retrieve_url url
# => "big list of book titles"
