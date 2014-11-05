#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::ShowInput < Pry::ClassCommand
    match 'show-input'
    group 'Editing'
    description 'Show the contents of the input buffer for the current multi-line expression.'

    banner <<-'BANNER'
      Show the contents of the input buffer for the current multi-line expression.
    BANNER

    def process
      output.puts Code.new(eval_string).with_line_numbers
    end
  end

  Pry::Commands.add_command(Pry::Command::ShowInput)
end
