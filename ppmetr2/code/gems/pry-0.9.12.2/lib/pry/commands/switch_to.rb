#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::SwitchTo < Pry::ClassCommand
    match 'switch-to'
    group 'Navigating Pry'
    description 'Start a new subsession on a binding in the current stack.'

    banner <<-'BANNER'
      Start a new subsession on a binding in the current stack (numbered by nesting).
    BANNER

    def process(selection)
      selection = selection.to_i

      if selection < 0 || selection > _pry_.binding_stack.size - 1
        raise CommandError, "Invalid binding index #{selection} - use `nesting` command to view valid indices."
      else
        Pry.start(_pry_.binding_stack[selection])
      end
    end
  end

  Pry::Commands.add_command(Pry::Command::SwitchTo)
end
