#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Module
  def delegate(*methods)
    options = methods.pop
    unless options.is_a?(Hash) && to = options[:to]
      raise ArgumentError, "Delegation needs a target. Supply an options hash with a :to key"
    end

    methods.each do |method|
      module_eval(<<-EOS, "(__DELEGATION__)", 1)
        def #{method}(*args, &block)
          #{to}.__send__(#{method.inspect}, *args, &block)
        end
      EOS
    end
  end
end