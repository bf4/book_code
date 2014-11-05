#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'
java_import java.util.Arrays
java_import java.util.LinkedList
java_import java.net.URI
java_import java.net.URL

java_import java.util.regex.Pattern
simple_us_phone = Pattern.compile "\\d{3}-\\d{3}-\\d{4}"
'Call 503-555-1212' =~ simple_us_phone # => 5

java_list = LinkedList.new(Arrays.as_list(['lock', 'stock', 'barrel'].to_java))

# assume this came from some Java function
java_list.entries         # => ["lock", "stock", "barrel"]
first_item = java_list[0] # => "lock"

java_list << 'crate'
java_list.join(',') # => "lock,stock,barrel,crate"

search_url = URL.new 'http://www.google.com'
upload_url = URL.new 'ftp://ftp.example.com'
java_list_of_urls = Arrays.as_list([search_url, upload_url].to_java)

# assume this came from some Java function
java_list_of_urls.entries
# => [#<Java::JavaNet::URL:0xacecf3>, #<Java::JavaNet::URL:0xf854bd>]

protocols = java_list_of_urls.map do |url|
  url.protocol
end
# => ["http", "ftp"]

uris = [URI.new('/uploads'),
        URI.new('/images'),
        URI.new('/stylesheets')]
uris.sort.map {|u| u.to_string}
# => ["/images", "/stylesheets", "/uploads"]

runnable = java.lang.Thread.new
run_it = runnable.to_proc
Thread.new &run_it

java_out = java.lang.System.out.to_io
java_out << 'Hello from JRuby!'

begin
  java.text.SimpleDateFormat.new(nil)
rescue java.lang.NullPointerException
  puts 'Ouch!'
end
