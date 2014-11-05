#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---


# A placeholder in the story for a reused value.
class Replacement
  # Only if we have a replacement for a given token is this class a match.
  def self.parse?( token, replacements )
    if token[0..1] == "((" and replacements.include? token[2..-1]
      new(token[2..-1], replacements)
    else
      false
    end
  end
  
  def initialize( name, replacements )
    @name         = name
    @replacements = replacements
  end
  
  def to_s
    @replacements[@name]
  end
end



# A question for the user, to be replaced with their answer.
class Question
  # If we see a ((, it's a prompt.  Save their answer if a name is given.
  def self.parse?( prompt, replacements )
    if prompt.sub!(/^\(\(/, "")
      prompt, name = prompt.split(":").reverse

      replacements[name] = nil unless name.nil?
      
      new(prompt, name, replacements)
    else
      false
    end
  end
  
  def initialize( prompt, name, replacements )
    @prompt       = prompt
    @name         = name
    @replacements = replacements
  end
  
  def to_s
    print "Enter #{@prompt}:  "
    answer = $stdin.gets.to_s.strip
  
    @replacements[@name] = answer unless @name.nil?
    
    answer
  end
end



# Ordinary prose.
class String
  # Anything is acceptable.
  def self.parse?( token, replacements )
    new(token)
  end
end



# argument parsing
unless ARGV.size == 1 and test(?e, ARGV[0])
  puts "Usage:  #{File.basename($PROGRAM_NAME)} MADLIB_FILE"
  exit  
end
madlib = <<MADLIB

#{File.basename(ARGV.first, ".madlib").tr("_", " ")}

#{File.read(ARGV.first)}
MADLIB

# tokenize input
tokens = madlib.split(/(\(\([^)]+)\)\)/).map do |token|
  token[0..1] == "((" ? token.gsub(/\s+/, " ") : token
end

# identify each part of the story
answers = Hash.new
story   = tokens.map do |token|
  [Replacement, Question, String].inject(false) do |element, kind|
    element = kind.parse?(token, answers) and break element
  end
end

# share the results
puts story.join

