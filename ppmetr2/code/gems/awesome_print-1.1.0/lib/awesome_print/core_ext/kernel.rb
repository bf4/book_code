#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Copyright (c) 2010-2012 Michael Dvorkin
#
# Awesome Print is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module Kernel

  def ai(options = {})
    ap = AwesomePrint::Inspector.new(options)
    ap.awesome self
  end
  alias :awesome_inspect :ai

  def ap(object, options = {})
    # ...
    puts object.ai(options)
    object unless AwesomePrint.console?
  end
  alias :awesome_print :ap

  module_function :ap
end
