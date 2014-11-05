#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::Bang < Pry::ClassCommand
    match '!'
    group 'Editing'
    description 'Clear the input buffer.'
    command_options :use_prefix => false

    banner <<-'BANNER'
      Clear the input buffer. Useful if the parsing process goes wrong and you get
      stuck in the read loop.
    BANNER

    def process
      output.puts 'Input buffer cleared!'
      eval_string.replace('')
    end
  end

  Pry::Commands.add_command(Pry::Command::Bang)
end
