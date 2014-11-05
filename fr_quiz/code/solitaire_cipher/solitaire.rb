#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

require "cipher_deck"
require "cipher"

card_file = if ARGV.first == "-f"
  ARGV.shift
  "cards.yaml"
else
  nil
end

keystream = CipherDeck.new(card_file) do |deck|
  loop do
    deck.move_down("A")
    2.times { deck.move_down("B") }
    deck.triple_cut
    deck.count_cut
    letter = deck.count_to_letter
  
    break letter if letter != :skip
  end
end
solitaire = Cipher.new(keystream)

if ARGV.size == 1 and ARGV.first =~ /^(?:[A-Z]{5} )*[A-Z]{5}$/
  puts solitaire.decrypt(ARGV.first)
elsif ARGV.size == 1
  puts solitaire.encrypt(ARGV.first)
else
  puts "Usage:  #{File.basename($PROGRAM_NAME)} MESSAGE"
  exit
end

keystream.save(card_file) unless card_file.nil?
