#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
players = ARGF.read.split("\n")
santas  = players.sort_by { rand }

while players.size > 0
  santa = santas.select { |s| s[/ \w+$/] != players[0][/ \w+$/] }.first
  santas.delete(santa)
  
  puts "#{santa} -> #{players.shift}"
end
