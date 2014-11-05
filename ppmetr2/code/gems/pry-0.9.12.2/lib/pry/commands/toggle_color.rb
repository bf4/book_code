#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::ToggleColor < Pry::ClassCommand
    match 'toggle-color'
    group 'Misc'
    description 'Toggle syntax highlighting.'

    banner <<-'BANNER'
      Usage: toggle-color

      Toggle syntax highlighting.
    BANNER

    def process
      Pry.color = !Pry.color
      output.puts "Syntax highlighting #{Pry.color ? "on" : "off"}"
    end
  end

  Pry::Commands.add_command(Pry::Command::ToggleColor)
end
