#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
first = num = 1
while num <= 10_000_000_000
  # English conversion goes here!
  first = [first, num].sort.first if num % 2 != 0
  num += 1
end
p first
