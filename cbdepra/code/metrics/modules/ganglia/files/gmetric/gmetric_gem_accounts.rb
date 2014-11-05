#!/usr/bin/env ruby
#---
# Excerpted from "Deploying Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cbdepra for more book information.
#---
require 'rubygems'
require 'gmetric'
def recently_created_record_count
  cmd = 'mysql -uroot -proot --silent --skip-column-names '
  cmd += ' massiveapp_production --execute '
  cmd += '"select count(id) from accounts where '
  cmd += 'created_at > (now() - interval 1 hour)"'
  `#{cmd}`.strip.to_i
end
def publish(count)
  puts "Publishing accounts = #{count}" if ARGV.include?("-v")
  Ganglia::GMetric.send("33.33.13.38", 8649, {
    :name => "accounts",
    :type => "uint16",
    :value => count
  })
end
publish(recently_created_record_count)

