#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

# use Ruby's standard template engine
require "erb"

# storage for keyed question reuse
$answers = Hash.new

# asks a madlib question and returns an answer
def q_to_a( question )
  question.gsub!(/\s+/, " ")       # normalize spacing
  
  if $answers.include? question    # keyed question
    $answers[question]
  else                             # new question
    key = if question.sub!(/^\s*(.+?)\s*:\s*/, "") then $1 else nil end
    
    print "Give me #{question}:  "
    answer = $stdin.gets.chomp
    
    $answers[key] = answer unless key.nil?
    
    answer
  end
end

# usage
unless ARGV.size == 1 and test(?e, ARGV[0])
  puts "Usage:  #{File.basename($PROGRAM_NAME)} MADLIB_FILE"
  exit  
end

# load Madlib, with title
madlib = "\n#{File.basename(ARGV.first, '.madlib').tr('_', ' ')}\n\n" +
         File.read(ARGV.first)
# convert ((...)) to <%= q_to_a('...') %>
madlib.gsub!(/\(\(\s*(.+?)\s*\)\)/, "<%= q_to_a('\\1') %>")
# run template
ERB.new(madlib).run
