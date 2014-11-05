#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
# Assume @foo doesn't exist yet.

@foo ||= 42

puts @foo # >> 42

# The next line will not do anything,
# since @foo already has a true value.

@foo ||= 25

puts @foo # >> 42
