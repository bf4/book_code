#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
class YourPlayer < Player

  def initialize( opponent_name )
    # (optional) called at the start of a match verses opponent
    # opponent_name = String of opponent's class name
    #
    # Player's constructor sets @opponent_name
  end

  def choose
    # (required) return your choice of :paper, :rock or :scissors
  end

  def result( your_choice, opponents_choice, win_lose_or_draw )
    # (optional) called after each choice you make to give feedback
    # your_choice      = your choice
    # oppenents_choice = opponent's choice
    # win_lose_or_draw = :win, :lose or :draw, your result
  end
end
