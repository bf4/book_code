#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'acts_as_taggable'
ActiveRecord::Base.send(:include, ActiveRecord::Acts::Taggable)

require File.dirname(__FILE__) + '/lib/tagging'
require File.dirname(__FILE__) + '/lib/tag'