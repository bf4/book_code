#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
# CNMeanPlayer: Pick a random choice.  If you win, use it again; else,
#   use the opponent's choice.

class CNMeanPlayer < Player
  def initialize(opponent)
    super
    @last_choice = [:rock, :scissors, :paper][rand(3)]
  end
  
  def choose
    @last_choice
  end
  
  def result(you, them, win_lose_or_draw)
    if win_lose_or_draw == :win
      @last_choice = you
    else
      @last_choice = them
    end
  end
end
