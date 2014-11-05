#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
# CNBiasBreaker: Always use the choice that beats what the opponent
#   chose most often.

class CNBiasBreaker < Player
  def initialize(opponent)
    super
    @biases = {:rock => 0, :scissors => 0, :paper => 0}
    @hit = {:rock => :paper, :paper => :scissors, :scissors => :rock}
  end
  
  def choose
    @hit[@biases.max {|a, b| a[1] <=> b[1]}.first]
  end
  
  def result( you, them, win_lose_or_draw )
    @biases[them] += 1
  end
end
