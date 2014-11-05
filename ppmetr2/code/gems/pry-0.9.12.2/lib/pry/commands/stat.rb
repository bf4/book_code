#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::Stat < Pry::ClassCommand
    match 'stat'
    group 'Introspection'
    description 'View method information and set _file_ and _dir_ locals.'
    command_options :shellwords => false

    banner <<-'BANNER'
        Usage: stat [OPTIONS] [METH]

        Show method information for method METH and set _file_ and _dir_ locals.

        stat hello_method
    BANNER

    def options(opt)
      method_options(opt)
    end

    def process
      meth = method_object
      aliases = meth.aliases

      output.puts unindent <<-EOS
        Method Information:
        --
        Name: #{meth.name}
        Alias#{ "es" if aliases.length > 1 }: #{ aliases.any? ? aliases.join(", ") : "None." }
        Owner: #{meth.owner ? meth.owner : "Unknown"}
        Visibility: #{meth.visibility}
        Type: #{meth.is_a?(::Method) ? "Bound" : "Unbound"}
        Arity: #{meth.arity}
        Method Signature: #{meth.signature}
        Source Location: #{meth.source_location ? meth.source_location.join(":") : "Not found."}
      EOS
    end
  end

  Pry::Commands.add_command(Pry::Command::Stat)
end
