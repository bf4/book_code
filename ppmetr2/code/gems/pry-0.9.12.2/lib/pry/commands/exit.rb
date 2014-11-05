#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::Exit < Pry::ClassCommand
    match 'exit'
    group 'Navigating Pry'
    description 'Pop the previous binding.'
    command_options :keep_retval => true

    banner <<-'BANNER'
      Usage:   exit [OPTIONS] [--help]
      Aliases: quit

      Pop the previous binding (does NOT exit program). It can be useful to exit a
      context with a user-provided value. For instance an exit value can be used to
      determine program flow.

      exit "pry this"
      exit

      https://github.com/pry/pry/wiki/State-navigation#wiki-Exit_with_value
    BANNER

    def process
      if _pry_.binding_stack.one?
        _pry_.run_command "exit-all #{arg_string}"
      else
        # otherwise just pop a binding and return user supplied value
        process_pop_and_return
      end
    end

    def process_pop_and_return
      popped_object = _pry_.binding_stack.pop.eval('self')

      # return a user-specified value if given otherwise return the object
      return target.eval(arg_string) unless arg_string.empty?
      popped_object
    end
  end

  Pry::Commands.add_command(Pry::Command::Exit)
  Pry::Commands.alias_command 'quit', 'exit'
end
