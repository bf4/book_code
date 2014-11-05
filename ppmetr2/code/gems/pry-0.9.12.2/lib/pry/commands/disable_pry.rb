#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::DisablePry < Pry::ClassCommand
    match 'disable-pry'
    group 'Navigating Pry'
    description 'Stops all future calls to pry and exits the current session.'

    banner <<-'BANNER'
      Usage: disable-pry

      After this command is run any further calls to pry will immediately return `nil`
      without interrupting the flow of your program. This is particularly useful when
      you've debugged the problem you were having, and now wish the program to run to
      the end.

      As alternatives, consider using `exit!` to force the current Ruby process
      to quit immediately; or using `edit-method -p` to remove the `binding.pry`
      from the code.
    BANNER

    def process
      ENV['DISABLE_PRY'] = 'true'
      _pry_.run_command "exit"
    end
  end

  Pry::Commands.add_command(Pry::Command::DisablePry)
end
