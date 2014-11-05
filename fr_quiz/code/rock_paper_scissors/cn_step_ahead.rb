#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
# CNStepAhead: Try to think a step ahead.  If you win, use the choice where
#   you would have lost.  If you lose, use the choice where you would have won.
#   Use the same on a draw.

class CNStepAhead < Player
  def initialize(opponent)
    super
    @choice = [:rock, :scissors, :paper][rand(3)]
  end
  
  def choose
    @choice
  end
  
  def result(you, them, win_lose_or_draw)
    case win_lose_or_draw
    when :win
      @choice = {:rock => :paper, :paper => :scissors, :scissors => :paper}[them]
    when :lose
      @choice = {:rock => :scissors, :scissors => :paper, :paper => :rock}[you]
    end
  end
end
