#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'rails/generators'
require 'active_support/core_ext/object/inclusion'

Rails::Generators.configure!

if ARGV.first.in?([nil, "-h", "--help"])
  Rails::Generators.help 'generate'
  exit
end

name = ARGV.shift
Rails::Generators.invoke name, ARGV, :behavior => :invoke, :destination_root => Rails.root
