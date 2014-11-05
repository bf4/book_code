#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
FACES = "AKQJT98765432"
SUITS = "cdhs"

deck = []                             # build a deck
FACES.each_byte do |f|
  SUITS.each_byte do |s|
    deck.push(f.chr + s.chr)
  end
end

3.times do                            # shuffle deck
  shuf = []
  deck.each do |c|
    loc = rand(shuf.size + 1)
    shuf.insert(loc, c)
  end
  deck = shuf.reverse
end

common = Array.new(5) { deck.pop }    # deal common cards

# deal player's hole cards
hole = Array.new(8) { Array.new(2) { deck.pop } }

hands = []                            # output hands
all_fold = true
while all_fold do
  hands = []
  hole.each do |h|
    num_common = [0, 3, 4, 5][rand(4)]
    if num_common == 5
      all_fold = false
    end
    if num_common > 0
      hand = h + common[0 ... num_common]
    else
      hand = h
    end
    hands.push(hand.join(' '))
  end
end

hands.each { |h| puts h }
