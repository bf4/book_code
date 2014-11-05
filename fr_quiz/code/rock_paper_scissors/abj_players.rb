#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
# AJBMetaPlayer.rb
# (c) Avi Bryant 2005
# heavily inspired by Dan Egnor's "Iocaine Powder":
# http://dan.egnor.name/iocaine.html

class Hash
  def max_key
    max{|a,b| a[1]<=>b[1]}[0] unless empty?
  end
end

class Symbol
  def defeat
    case self
    when :paper
      :scissors
    when :scissors
      :rock
    when :rock
      :paper
    end
  end
end


class AJBRandomPlayer < Player
  def choose
     [:paper, :scissors, :rock][rand(3)]
  end
end


class AJBFrequencyPlayer < AJBRandomPlayer
  def initialize(op)
    super
    @frequencies = Hash.new(0)
  end

  def choose
    (@frequencies.max_key || super).defeat
  end

  def result(y, t, win)
    @frequencies[t] += 1
  end
end

class AJBHistoryPlayer < AJBRandomPlayer

  class Node    
    def initialize
      @children = {}
      @scores = Hash.new(0)
    end

    def add_child(key)
      @scores[key] += 1
      @children[key] ||= Node.new
    end

    def add_scores_to(totals)
      @scores.each{|k,v| totals[k] += v}
    end
  end

  MaxNodes = 20

  def initialize(op)
    super
    @nodes = []
    @root = Node.new
  end

  def choose
    scores = Hash.new(0)
    @nodes.each{|n| n.add_scores_to(scores)}
    (scores.max_key || super).defeat
  end

  def result(y, t, win)
    (@nodes << @root).collect!{|n| n.add_child(t)}
    @nodes.shift until @nodes.size <= MaxNodes
   end
end

class AJBMetaPlayer < Player
  class PlayerDecorator
    def initialize(player)
      @player = player
    end
  end

  class Defeater < PlayerDecorator
    def choose
      @player.choose.defeat
    end

    def result(y, t, win)
    end
  end

  class Inverter < PlayerDecorator
    def choose
      @player.choose
    end

    def result(y, t, win)
      @player.result(t, y, !win)
    end
  end

  def initialize(op)
    super
    @players =  [AJBRandomPlayer.new(op)] +
          variations(AJBHistoryPlayer) +
          variations(AJBFrequencyPlayer)
    @scores = {}
    @players.each{|p| @scores[p] = 0}
  end

  def result(y, t, win)
    @players.each{|p| score(p, t)}
    @players.each{|p| p.result(y, t, win)}
  end

  def choose
    @scores.max_key.choose
  end

  :private

  def variations(klass)
    straight = klass.new(@opponent)
    inverted = Inverter.new(klass.new(@opponent))
    [straight,
    inverted,
    Defeater.new(straight),
    Defeater.new(inverted),
    Defeater.new(Defeater.new(straight)),
    Defeater.new(Defeater.new(inverted))]
  end

  def score(player, move)
    @scores[player] += ScoreTable[[player.choose, move]]
  end 

  ScoreTable =
    {[:scissors, :rock] => -1,
    [:scissors, :scissors] => 0,
    [:scissors, :paper] => 1,
    [:paper, :rock] => 1,
    [:paper, :scissors] => -1,
    [:paper, :paper] => 0,
    [:rock, :rock] => 0,
    [:rock, :scissors] => 1,
    [:rock, :paper] => -1}   
end
