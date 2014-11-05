#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
# A workaround to make Rails 2.1 gem dependency easier on case-sensitive filesystems.
# Since the gem name is RedCloth and the file is redcloth.rb, config.gem 'RedCloth' doesn't
# work.  You'd have to use config.gem 'RedCloth', :lib => 'redcloth', and that's not 
# immediately obvious.  This file remedies that.
#
require File.join(File.dirname(__FILE__), '..', 'redcloth')