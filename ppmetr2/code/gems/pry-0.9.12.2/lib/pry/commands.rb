#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Default commands used by Pry.
Pry::Commands = Pry::CommandSet.new

Dir[File.expand_path('../commands', __FILE__) + '/*.rb'].each do |file|
  require file
end
