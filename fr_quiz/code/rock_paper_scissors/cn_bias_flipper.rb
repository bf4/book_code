#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
# CNBiasFlipper:  Always use the choice that beats what the opponent chose most
#    or second-to-most often.

class CNBiasFlipper < Player
  def initialize(opponent)
    super
    @biases = {:rock => 0, :scissors => 0, :paper => 0}
    @hit = {:rock => :paper, :paper => :scissors, :scissors => :rock}
  end
  
  def choose
    b = @biases.sort_by {|k, v| -v}
    if b[0][1] > b[1][1]*1.5
      @hit[b[0].first]
    else
      @hit[b[1].first]
    end
  end
  
  def result( you, them, win_lose_or_draw )
    @biases[them] += 1
  end
end
