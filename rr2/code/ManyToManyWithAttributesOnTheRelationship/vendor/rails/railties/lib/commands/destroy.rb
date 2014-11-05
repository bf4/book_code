#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require "#{RAILS_ROOT}/config/environment"
require 'rails_generator'
require 'rails_generator/scripts/destroy'

ARGV.shift if ['--help', '-h'].include?(ARGV[0])
Rails::Generator::Scripts::Destroy.new.run(ARGV)
