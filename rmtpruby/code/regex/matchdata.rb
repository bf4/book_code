#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
url = "https://example.com"

matches = url.match(/([a-z]+):\/\/([\w\.]+)/)
# => #<MatchData "https://example.com" 1:"https" 2:"example.com">
if matches
  puts matches[0]
  puts matches[1]
  puts matches[2]
end
# >> https://example.com
# >> https
# >> example.com
