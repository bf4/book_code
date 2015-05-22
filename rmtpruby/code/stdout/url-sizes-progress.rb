#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "open-uri"

urls = ARGF.readlines.map(&:chomp)
total_urls = urls.length

urls.each_with_index do |url, n|
  $stderr.print "\rFetching url #{n + 1} of #{total_urls}...  "
  html = open(url).read
  puts "#{html.bytesize} bytes (#{url})"
end

$stderr.print "\r"
