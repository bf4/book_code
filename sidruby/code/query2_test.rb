#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
class Foo
  # initialize foo
  def initialize(name)
    @foo = name
  end

  def foo; end
  def baz; end
end

class Bar < Foo
  # initialize bar and foo
  def initialize(name)
    super("bar #{name}")
  end
  def bar; end
end
