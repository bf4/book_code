#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::SimplePrompt < Pry::ClassCommand
    match 'simple-prompt'
    group 'Misc'
    description 'Toggle the simple prompt.'

    banner <<-'BANNER'
      Toggle the simple prompt.
    BANNER

    def process
      case _pry_.prompt
      when Pry::SIMPLE_PROMPT
        _pry_.pop_prompt
      else
        _pry_.push_prompt Pry::SIMPLE_PROMPT
      end
    end
  end

  Pry::Commands.add_command(Pry::Command::SimplePrompt)
end
