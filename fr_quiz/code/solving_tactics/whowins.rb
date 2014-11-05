#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
require 'tactics'

puts %(#{Tactics.new.play == Tactics::WIN ? "First" : "Second"} player wins.)
