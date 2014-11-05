#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
# This file makes it possible to install RubyCAS-Client as a Rails plugin.

$: << File.expand_path(File.dirname(__FILE__))+'/lib'

require 'casclient'
require 'casclient/frameworks/rails/filter'