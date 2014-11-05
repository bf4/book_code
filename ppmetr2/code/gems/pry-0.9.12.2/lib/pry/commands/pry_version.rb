#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::Version < Pry::ClassCommand
    match 'pry-version'
    group 'Misc'
    description 'Show Pry version.'

    banner <<-'BANNER'
      Show Pry version.
    BANNER

    def process
      output.puts "Pry version: #{Pry::VERSION} on Ruby #{RUBY_VERSION}."
    end
  end

  Pry::Commands.add_command(Pry::Command::Version)
end
