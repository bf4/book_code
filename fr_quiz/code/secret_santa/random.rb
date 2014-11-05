#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
def correct_match?( givers, receivers )
  receivers.each_with_index do |who, i|
    return false if who[/ \w+$/] == givers[i][/ \w+$/]
  end
  return true
end

players = ARGF.read.split("\n")

begin
  santas = players.sort_by { rand }
end until correct_match?(santas, players)

santas.each_with_index do |s, i|
  puts "#{players[i]} -> #{s}"
end
