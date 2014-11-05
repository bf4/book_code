#!/usr/bin/env ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

class JEGQueuePlayer < Player
  QUEUE = [ :rock, :scissors, :scissors ]

  def initialize( opponent_name )
    super
    @index = 0
  end
  
  def choose
    choice = QUEUE[@index]
    @index += 1
    @index = 0 if @index == QUEUE.size
    choice
  end
end
