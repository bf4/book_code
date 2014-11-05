#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# rake/gempackagetask is deprecated in favor of rubygems/package_task

warn 'rake/gempackagetask is deprecated.  Use rubygems/package_task instead'

require 'rubygems'
require 'rubygems/package_task'

require 'rake'

# :stopdoc:

module Rake
  GemPackageTask = Gem::PackageTask
end

