#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Object #:nodoc:
  # A Ruby-ized realization of the K combinator, courtesy of Mikael Brockman.
  #
  #   def foo
  #     returning values = [] do
  #       values << 'bar'
  #       values << 'baz'
  #     end
  #   end
  #
  #   foo # => ['bar', 'baz']
  #
  #   def foo
  #     returning [] do |values|
  #       values << 'bar'
  #       values << 'baz'
  #     end
  #   end
  #
  #   foo # => ['bar', 'baz']
  #
  def returning(value)
    yield(value)
    value
  end

  def with_options(options)
    yield ActiveSupport::OptionMerger.new(self, options)
  end
  
  def to_json
    ActiveSupport::JSON.encode(self)
  end
end