#! /usr/bin/env ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

def ask(prompt)
  loop do
    print prompt, ' '
    $stdout.flush
    s = gets
    exit if s == nil
    s.chomp!
    if s == 'y' or s == 'yes'
      return true
    elsif s == 'n' or s == 'no'
      return false
    else
      $stderr.puts "Please answer yes or no."
    end
  end
end

def my_readline
  s = gets
  exit if s == nil
  s.chomp!
  return s
end

class AnimalQuiz
  DEFAULT_ANSWERS = ['an elephant']

  def initialize(filename)
    if not filename
      @answers = DEFAULT_ANSWERS
    else
      begin
        File.open(filename) do |f|
          @answers = eval(f.read)
        end
      rescue Errno::ENOENT
        @answers = DEFAULT_ANSWERS
      end
    end

    @current = nil
  end

  def save(filename)
    File.open(filename, 'w') do |f|
      f.puts @answers.inspect
    end
  end

  def run_once
    unless @current
      @current = @answers
      puts 'Think of an animal...'
    end

    if @current.length == 1
      if ask("Is it #{@current[0]}?")
        puts 'I win!  Pretty smart, aren\'t I?'
      else
        print 'You win!  Help me learn from my '
        puts 'mistake before you go...'
        puts 'What animal were you thinking of?'
        correct = my_readline
        incorrect = @current[0]
        print 'Give me a question to distinguish '
        puts "#{correct} from #{incorrect}."
        question = my_readline
        if ask("For #{correct}, what is the" \
          + ' answer to your question?')
          @current.push [correct]
          @current.push [incorrect]
        else
          @current.push [incorrect]
          @current.push [correct]
        end
        @current[0] = question
      end
      if ask('Play again?')
        @current = nil
        puts
      else
        exit
      end
    elsif @current.length == 3
      if ask(@current[0])
        @current = @current[1]
      else
        @current = @current[2]
      end
    end
  end

  def run
    loop {run_once}
  end
end

filename = ENV['HOME'] + '/.animal-quiz'

quiz = AnimalQuiz.new(filename)
begin
  quiz.run
ensure
  quiz.save filename
end
