#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::ShellMode < Pry::ClassCommand
    match 'shell-mode'
    group 'Input and Output'
    description 'Toggle shell mode. Bring in pwd prompt and file completion.'

    banner <<-'BANNER'
      Toggle shell mode. Bring in pwd prompt and file completion.
    BANNER

    def process
      case _pry_.prompt
      when Pry::SHELL_PROMPT
        _pry_.pop_prompt
        _pry_.custom_completions = Pry::DEFAULT_CUSTOM_COMPLETIONS
      else
        _pry_.push_prompt Pry::SHELL_PROMPT
        _pry_.custom_completions = Pry::FILE_COMPLETIONS
        Readline.completion_proc = Pry::InputCompleter.build_completion_proc target,
        _pry_.instance_eval(&Pry::FILE_COMPLETIONS)
      end
    end
  end

  Pry::Commands.add_command(Pry::Command::ShellMode)
  Pry::Commands.alias_command 'file-mode', 'shell-mode'
end
