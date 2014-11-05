#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/core_ext/module/aliasing'

module Marshal
  class << self
    def load_with_autoloading(source)
      load_without_autoloading(source)
    rescue ArgumentError, NameError => exc
      if exc.message.match(%r|undefined class/module (.+)|)
        # try loading the class/module
        $1.constantize
        # if it is a IO we need to go back to read the object
        source.rewind if source.respond_to?(:rewind)
        retry
      else
        raise exc
      end
    end

    alias_method_chain :load, :autoloading
  end
end
