#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

# argument parsing
DICTIONARY = if ARGV.first == "-w"
  ARGV.shift
  ARGV.shift
else
  "/usr/share/dict/words"
end
if ARGV.first =~ /\A\d+\Z/
  LIMIT = ARGV.first.to_i
else
  puts "Usage:  #{File.basename($PROGRAM_NAME)} [-d DICTIONARY_FILE] LIMIT"
  exit
end

# storage for all the stems we find and the letters they combine with
stems = Hash.new

# read the dictionary
File.foreach(DICTIONARY) do |word|
  # clean up the words
  word.downcase!
  word.delete!("^a-z")
  
  # skip anything but a seven letter word
  next unless word.length == 7
  
  # translate word to an alphabetized arrangement of letters
  signature = word.split(//).sort
  # remove each letter from the word to create stems
  signature.uniq.each do |letter|
    stem = signature.join.sub(letter, "")
    (stems[stem] ||= Hash.new)[letter] = true
  end
end

# drop anything below the limit and reorder
result = stems.reject { |stem, combines| combines.size < LIMIT }.
               sort_by { |stem, combines| -combines.size }

# display the results
result.each do |stem, combines|
  puts "#{stem} (#{combines.size}) #{combines.keys.sort.join}"
end
