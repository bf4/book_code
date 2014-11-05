#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
# I have access to my directory and the Rails config.
raise 'directory expected but undefined in init.rb' unless defined? directory
raise 'config expected but undefined in init.rb' unless defined? config

# My lib/ dir must be in the load path.
require 'stubby_mixin'
raise 'missing mixin from my lib/ dir' unless defined? StubbyMixin
