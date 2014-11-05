#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---


require "highline/answer"

class HighLine
  class QuestionError < StandardError
    # do nothing, just creating a unique error type
  end
  
  # Create an instance of HighLine, connected to the streams _input_
  # and _output_.
  def initialize( input = $stdin, output = $stdout )
    @input  = input
    @output = output
  end
  
  def ask( question, answer_type = String, &details )
    answer = Answer.new(answer_type, &details)
    
    say(question)
    begin
      input = fetch_line
      unless answer.valid?(input)
        explain_error( question,
                       answer.responses[:not_valid],
                       answer.ask_on_error )
        raise QuestionError
      end
      result = answer.convert(input)
      if answer.accept?(result)
        result
      else
        explain_error( question,
                       answer.responses[:failed_tests],
                       answer.ask_on_error )
        raise QuestionError
      end
    rescue QuestionError
      retry
    rescue ArgumentError
      explain_error( question,
                     answer.responses[:invalid_type],
                     answer.ask_on_error )
      retry
    rescue NameError
      explain_error( question,
                     answer.responses[:ambiguous_completion],
                     answer.ask_on_error )
      retry
    end
  end
end



class HighLine
  def agree( yes_or_no_question )
    ask(yes_or_no_question, proc { |a| a =~ /\AY(?:es)?\Z/i ? true : false })
  end
  
  def say( statement )
    if statement[-1, 1] == " " or statement[-1, 1] == "\t"
      @output.print(statement)
      @output.flush  
    else
      @output.puts(statement)
    end
  end
  
  private
  
  def explain_error( question, error, reask )
    say(error)
    if reask == :question
      say(question)
    elsif reask
      say(reask)
    end
  end
  
  def fetch_line(  )
    @input.gets.chomp
  end
end

