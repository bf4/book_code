#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
keys=Hash.new { |h, k|
   puts "Give me #{k.sub(/\A([^:]+):/, "")}:"
   h[$1]=$stdin.gets.chomp
}
puts "", $*[0].split(".")[0].gsub("_", " "),
     IO.read($*[0]).gsub(/\(\(([^)]+)\)\)/) { keys[$1] }
