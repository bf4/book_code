#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
module Codebreaker
  class Game
    def initialize(output)
      @output = output
    end

    def start(secret)
      @secret = secret
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Enter guess:'
    end

    def guess(guess)
      @output.puts '+'*exact_match_count(guess) + '-'*number_match_count(guess)
    end
    def exact_match_count(guess)
      (0..3).inject(0) do |count, index|
        count + (exact_match?(guess, index) ? 1 : 0)
      end
    end
    def number_match_count(guess)
      (0..3).inject(0) do |count, index|
        count + (number_match?(guess, index) ? 1 : 0)
      end
    end
    def exact_match?(guess, index)
      guess[index] == @secret[index]
    end
    def number_match?(guess, index)
      @secret.include?(guess[index]) && !exact_match?(guess, index)
    end
  end
end


