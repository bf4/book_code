#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'rake'

# Load the test files from the command line.
argv = ARGV.select do |argument|
  case argument
  when /^-/ then
    argument
  when /\*/ then
    FileList[argument].to_a.each do |file|
      require File.expand_path file
    end

    false
  else
    require File.expand_path argument

    false
  end
end

ARGV.replace argv

