#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::Reset < Pry::ClassCommand
    match 'reset'
    group 'Context'
    description 'Reset the REPL to a clean state.'

    banner <<-'BANNER'
      Reset the REPL to a clean state.
    BANNER

    def process
      output.puts 'Pry reset.'
      exec 'pry'
    end
  end

  Pry::Commands.add_command(Pry::Command::Reset)
end
