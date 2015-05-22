#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "json"

"hello, world".to_json
# => "\"hello, world\""
42.to_json
# => "42"
[1, 1, 2, 3, 5].to_json
# => "[1,1,2,3,5]"
{ "name" => "Alice", "age" => 32 }.to_json
# => "{\"name\":\"Alice\",\"age\":32}"
