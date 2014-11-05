#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'active_support'
require 'fileutils'

begin
  require_library_or_gem 'fcgi'
rescue Exception
  # FCGI not available
end

server = case ARGV.first
  when "lighttpd"
    ARGV.shift
  when "webrick"
    ARGV.shift
  else
    if RUBY_PLATFORM !~ /mswin/ && !silence_stderr { `lighttpd -version` }.blank? && defined?(FCGI)
      "lighttpd"
    else
      "webrick"
    end
end

if server == "webrick"
  puts "=> Booting WEBrick..."
else
  puts "=> Booting lighttpd (use 'script/server webrick' to force WEBrick)"
end

FileUtils.mkdir_p(%w( tmp/sessions tmp/cache tmp/sockets ))
require "commands/servers/#{server}"
