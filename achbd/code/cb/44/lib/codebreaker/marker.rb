#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
module Codebreaker
  class Marker
    def initialize(secret, guess)
      @secret, @guess = secret, guess
    end

    def exact_match_count
      (0..3).inject(0) do |count, index|
        count + (exact_match?(index) ? 1 : 0)
      end
    end

    def number_match_count
      (0..3).inject(0) do |count, index|
        count + (number_match?(index) ? 1 : 0)
      end
    end

    def exact_match?(index)
      @guess[index] == @secret[index]
    end

    def number_match?(index)
      @secret.include?(@guess[index]) && !exact_match?(index)
    end
  end
end
