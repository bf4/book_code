#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'webrick'
require 'tofu/tofulet'
require 'rinda/ring'

class TofuletFront
  include DRbUndumped
  def initialize(webrick)
    @webrick = webrick
  end

  def mount_tofulet(point, bartender)
    @webrick.unmount(point)
    @webrick.mount(point, WEBrick::Tofulet, bartender)
  end
  alias mount mount_tofulet
end

def main
  DRb.start_service

  logger = WEBrick::Log::new($stderr, WEBrick::Log::DEBUG)

  s = WEBrick::HTTPServer.new(:Port => 2000,
                              :AddressFamily => Socket::AF_INET,
                              :BindAddress => ENV['HOSTNAME'],
                              :Logger => logger)
  front = TofuletFront.new(s)
  provider = Rinda::RingProvider.new(:Tofulet, front, 'tofu-runner')
  provider.provide

  trap("INT"){ s.shutdown }
  s.start
end

main