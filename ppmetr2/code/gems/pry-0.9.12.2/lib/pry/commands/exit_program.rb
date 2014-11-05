#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::ExitProgram < Pry::ClassCommand
    match 'exit-program'
    group 'Navigating Pry'
    description 'End the current program.'

    banner <<-'BANNER'
      Usage:   exit-program [--help]
      Aliases: quit-program
               !!!

      End the current program.
    BANNER

    def process
      Pry.save_history if Pry.config.history.should_save
      Kernel.exit target.eval(arg_string).to_i
    end
  end

  Pry::Commands.add_command(Pry::Command::ExitProgram)
  Pry::Commands.alias_command 'quit-program', 'exit-program'
  Pry::Commands.alias_command '!!!', 'exit-program'
end
