#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
KILLER = { :rock => :paper, :paper => :scissors, :scissors => :rock }

class BHCheatPlayer < Player

  def initialize( opponent )
    super
    @opp = Object.const_get(opponent).new(self)
  end

  def choose
    KILLER[@opp.choose]
  end

  def result(you,them,result)
    @opp.result(them,you,result)
  end

end
