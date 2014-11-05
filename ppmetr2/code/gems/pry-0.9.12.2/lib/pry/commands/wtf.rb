#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::Wtf < Pry::ClassCommand
    match /wtf([?!]*)/
    group 'Context'
    description 'Show the backtrace of the most recent exception.'
    options :listing => 'wtf?'

    banner <<-'BANNER'
      Usage: wtf[?|!]

      Show's a few lines of the backtrace of the most recent exception (also available
      as `_ex_.backtrace`). If you want to see more lines, add more question marks or
      exclamation marks.

      wtf?
      wtf?!???!?!?

      # To see the entire backtrace, pass the `-v` or `--verbose` flag.
      wtf -v
    BANNER

    def options(opt)
      opt.on :v, :verbose, "Show the full backtrace"
    end

    def process
      raise Pry::CommandError, "No most-recent exception" unless exception

      output.puts "#{text.bold('Exception:')} #{exception.class}: #{exception}\n--"
      if opts.verbose?
        output.puts with_line_numbers(backtrace)
      else
        output.puts with_line_numbers(backtrace.first(size_of_backtrace))
      end
    end

    private

    def exception
      _pry_.last_exception
    end

    def with_line_numbers(bt)
      Pry::Code.new(bt, 0, :text).with_line_numbers.to_s
    end

    def backtrace
      exception.backtrace
    end

    def size_of_backtrace
      [captures[0].size, 0.5].max * 10
  end
end

Pry::Commands.add_command(Pry::Command::Wtf)
end
