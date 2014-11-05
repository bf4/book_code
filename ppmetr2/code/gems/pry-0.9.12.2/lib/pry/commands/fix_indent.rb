#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::FixIndent < Pry::ClassCommand
    match 'fix-indent'
    group 'Input and Output'

    description "Correct the indentation for contents of the input buffer"

    banner <<-USAGE
      Usage: fix-indent
    USAGE

    def process
      indented_str = Pry::Indent.indent(eval_string)
      eval_string.replace indented_str
    end
  end

  Pry::Commands.add_command(Pry::Command::FixIndent)
end
