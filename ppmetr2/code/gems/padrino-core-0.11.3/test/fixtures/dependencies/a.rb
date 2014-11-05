#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# This file will be safe loaded three times.
# The first one fail because B and C constant are not defined
# The second one file because B requires C constant so will not be loaded
# The third one B and C are defined

# But here we need some of b.rb
A_result = [B, C]

A = "A"
