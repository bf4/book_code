#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# cattr_* became mattr_* aliases in 7dfbd91b0780fbd6a1dd9bfbc176e10894871d2d,
# but we keep this around for libraries that directly require it knowing they
# want cattr_*. No need to deprecate.
require 'active_support/core_ext/module/attribute_accessors'
