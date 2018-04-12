#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
class GuessingGame
  def play
    @number = rand(1..100)
    @guess = nil

    5.downto(1) do |remaining_guesses|
      break if @guess == @number
      puts "Pick a number 1-100 (#{remaining_guesses} guesses left):"
      @guess = gets.to_i
      check_guess
    end

    announce_result
  end

private

  def check_guess
    if @guess > @number
      puts "#{@guess} is too high!"
    elsif @guess < @number
      puts "#{@guess} is too low!"
    end
  end

  def announce_result
    if @guess == @number
      puts 'You won!'
    else
      puts "You lost! The number was: #{@number}"
    end
  end
end

# play the game if this file is run directly
GuessingGame.new.play if __FILE__.end_with?($PROGRAM_NAME)
