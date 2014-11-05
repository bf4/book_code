#!/usr/bin/env ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

require "filter"

### my algorithm ###
def isolate( list, test )
  if test.clean? list.join(" ")
    Array.new
  elsif list.size == 1
    list
  else
    left, right = list[0...(list.size / 2)], list[(list.size / 2)..-1]
    isolate(left, test) + isolate(right, test)
  end
end

### test code ###
# choose some random words to ban
words = ARGF.read.split " "
filter = LanguageFilter.new words.select { rand <= 0.01 }

# solve
start = Time.now
banned = isolate words, filter
time = Time.now - start

# display results
puts "#{words.size} words, #{banned.size} banned words found"
puts "Correct?  #{filter.verify banned}"
puts "Time taken: #{time} seconds"
puts "Calls: #{filter.clean_calls}"
puts "Words:"
puts banned.map { |word| "\t" + word }
