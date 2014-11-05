#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Module
  def include_all_modules_from(parent_module)
    parent_module.constants.each do |const|
      mod = parent_module.const_get(const)
      if mod.class == Module
        send(:include, mod)
        include_all_modules_from(mod)
      end
    end
  end
end

def helper
  @helper_proxy ||= Object.new 
end

require 'application'

class << helper 
  include_all_modules_from ActionView
end

@controller = ApplicationController.new
