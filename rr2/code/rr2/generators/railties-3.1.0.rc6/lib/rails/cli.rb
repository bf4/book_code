#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'rbconfig'
require 'rails/script_rails_loader'

# If we are inside a Rails application this method performs an exec and thus
# the rest of this script is not run.
Rails::ScriptRailsLoader.exec_script_rails!

require 'rails/ruby_version_check'
Signal.trap("INT") { puts; exit(1) }

if ARGV.first == 'plugin'
  ARGV.shift
  require 'rails/commands/plugin_new'
else
  require 'rails/commands/application'
end
