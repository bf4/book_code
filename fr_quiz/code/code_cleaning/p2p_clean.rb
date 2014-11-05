#!/usr/local/bin/ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
#
# p2p.rb
#
# Server: ruby p2p.rb password server public-uri private-uri merge-servers
# Sample: ruby p2p.rb foobar server druby://123.123.123.123:1337
#         druby://:1337 druby://foo.bar:1337
# Client: ruby p2p.rb password client server-uri download-pattern [list-only]
# Sample: ruby p2p.rb foobar client druby://localhost:1337 *.rb
#############################################################################
# You are not allowed to use this application for anything illegal
# unless you live inside a sane place. Insane places currently include
# California (see link) and might soon include the complete
# USA. People using this software are responsible for themselves. I
# can't prevent them from doing illegal stuff for obvious reasons. So
# have fun, and do whatever you can get away with for now.
# 
# http://info.sen.ca.gov/pub/bill/sen/sb_0051-0100/-
#           sb_96_bill_20050114_introduced.html
#############################################################################

require'drb'

# define utility methods
def create_drb_object( uri )
  DRbObject.new(nil, uri)
end

def encode( uri )
  [PASSWORD, uri].hash
end

def make_safe( path )
  File.basename(path[/[^|]+/])
end

# parse command-line options
PASSWORD, MODE, URI, VAR, *OPTIONS = ARGV

class Server                    # define server operation
  new.methods.map{ |method| private(method) unless method[/_[_t]/] }

  def initialize
    @servers = OPTIONS.dup
    add(URI)
    @servers.each do |u|
      create_drb_object(u).add(URI) unless u == URI
    end
  end
  
  attr_reader :servers

  def add( z = OPTIONS )
    @servers.push(*z).uniq!
    @servers
  end
  
  def list( code, pattern )
    if encode(URI) == code
      Dir[make_safe(pattern)]
    else
      @servers
    end
  end
  
  def read( file )
    open(make_safe(file), "rb").read
  end
end

if MODE["s"]    # server
  DRb.start_service(VAR, Server.new)
  sleep
else            # client
  servers = create_drb_object(URI).servers
  servers.each do |server|
    files = create_drb_object(server).list(encode(server), VAR).map do |f|
      make_safe f
    end
    files.each do |file|
      if OPTIONS[0]
        p(file)
      else 
        open(file, "wb") do |f|
          f << create_drb_object(server).read(file)
        end
      end
    end
  end
end
