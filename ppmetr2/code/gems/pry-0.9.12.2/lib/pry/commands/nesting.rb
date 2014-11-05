#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::Nesting < Pry::ClassCommand
    match 'nesting'
    group 'Navigating Pry'
    description 'Show nesting information.'

    banner <<-'BANNER'
      Show nesting information.
    BANNER

    def process
      output.puts 'Nesting status:'
      output.puts '--'
      _pry_.binding_stack.each_with_index do |obj, level|
        if level == 0
          output.puts "#{level}. #{Pry.view_clip(obj.eval('self'))} (Pry top level)"
        else
          output.puts "#{level}. #{Pry.view_clip(obj.eval('self'))}"
        end
      end
    end
  end

  Pry::Commands.add_command(Pry::Command::Nesting)
end
