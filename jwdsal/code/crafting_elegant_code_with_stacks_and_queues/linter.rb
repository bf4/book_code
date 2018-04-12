#---
# Excerpted from "A Common-Sense Guide to Data Structures and Algorithms",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jwdsal for more book information.
#---
class Linter

  attr_reader :error

  def initialize
    # We use a simple array to serve as our stack:
    @stack = []
  end

  def lint(text)
    # We start a loop which reads each character in our text:
    text.each_char.with_index do |char, index|

      if opening_brace?(char)

        # If the character is an opening brace, we push it onto the stack:
        @stack.push(char)
      elsif closing_brace?(char)

        if closes_most_recent_opening_brace?(char)

          # If the character closes the most recent opening brace,
          # we pop the opening brace from our stack:
          @stack.pop

        else # if the character does NOT close the most recent opening brace
 
          @error = "Incorrect closing brace: #{char} at index #{index}"
          return
        end
      end

    end

    if @stack.any?

      # If we get to the end of line, and the stack isn't empty,
      # that means we have an opening brace without a corresponding
      # closing brace:
      @error = "#{@stack.last} does not have a closing brace"
    end
  end

  private

  def opening_brace?(char)
    ["(", "[", "{"].include?(char)
  end

  def closing_brace?(char)
    [")", "]", "}"].include?(char)
  end

  def opening_brace_of(char)
    {")" => "(", "]" => "[", "}" => "{"}[char]
  end

  def most_recent_opening_brace
    @stack.last 
  end

  def closes_most_recent_opening_brace?(char)
    opening_brace_of(char) == most_recent_opening_brace
  end

end

linter = Linter.new
linter.lint("( var x = { y: [1, 2, 3] } )")
puts linter.error

linter = Linter.new
linter.lint("( var x = { y: [1, 2, 3] ) }")
puts linter.error

linter = Linter.new
linter.lint("( var x = { y: [1, 2, 3] }")
puts linter.error