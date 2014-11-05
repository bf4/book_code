#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'drb/drb'
require 'drb/gw'
DRb.install_id_conv(DRb::GWIdConv.new)
gw = DRb::GW.new
s1 = DRb::DRbServer.new(ARGV.shift, gw)
s2 = DRb::DRbServer.new(ARGV.shift, gw)
s1.thread.join
s2.thread.join