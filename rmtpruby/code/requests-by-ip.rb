#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
requests =
  File.open("data/access_log") do |file|
    file
      .map { |line| { ip: line.split[0], url: line.split[5] } }
      .group_by { |request| request[:ip] }
      .each { |ip, requests| requests.map! { |r| r[:url] } }
  end

