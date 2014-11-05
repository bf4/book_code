#!/usr/bin/env ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
require 'yaml'
require 'ui'

def ui
  $ui ||= ConsoleUi.new
end

class Question
  def initialize(question, yes, no)
    @question = question
    @yes = yes
    @no = no
    @question << "?" unless @question =~ /\?$/
    @question.sub!(/^([a-z])/) { $1.upcase }
  end

  def walk
    if ui.ask_if @question
      @yes = @yes.walk
    else
      @no = @no.walk
    end
    self
  end
end

class Animal
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def walk
    if ui.ask_if "Is it #{an name}?"
      ui.say "Yea!  I win!\n\n"
      self
    else
      ui.say "Rats, I lose"
      ui.say "Help me play better next time."
      new_animal = ui.ask "What animal were you thinking of?"
      question = ui.ask "Give me a question " +
                        "to distinguish a #{an name} from #{an new_animal}."
      response = ui.ask_if "For #{an new_animal}, " +
                           "the answer to your question would be?"
      ui.say "Thank you\n\n"
      if response
        Question.new(question, Animal.new(new_animal), self)
      else
        Question.new(question, self, Animal.new(new_animal))
      end
    end
  end

  def an(animal)
    ((animal =~ /^[aeiou]/) ? "an " : "a ") + animal
  end
end

if File.exist? "animals.yaml"
  current = open("animals.yaml") { |f| YAML.load(f.read) }
else
  current = Animal.new("mouse")
end

loop do
  current = current.walk
  break unless  ui.ask_if "Play again?"
  ui.say "\n\n"
end

open("animals.yaml", "w") do |f| f.puts current.to_yaml end
