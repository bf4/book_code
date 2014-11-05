#!/usr/bin/env ruby
#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
#--
# Copyright 2004, 2006 by Jim Weirich (jim@weirichhouse.org).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.
#++

######################################################################
# BlankSlate has been promoted to a top level name and is now
# available as a standalone gem.  We make the name available in the
# Builder namespace for compatibility.
#
module Builder
  if Object::const_defined?(:BasicObject)
    BlankSlate = ::BasicObject
  else
    require 'blankslate'
    BlankSlate = ::BlankSlate
  end
end
