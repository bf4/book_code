#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::ImportSet < Pry::ClassCommand
    match 'import-set'
    group 'Commands'
    # TODO: Provide a better description with examples and a general conception
    # of this command.
    description 'Import a Pry command set.'

    banner <<-'BANNER'
      Import a Pry command set.
    BANNER

    def process(command_set_name)
      raise CommandError, "Provide a command set name" if command_set.nil?

      set = target.eval(arg_string)
      _pry_.commands.import set
    end
  end

  Pry::Commands.add_command(Pry::Command::ImportSet)
end
