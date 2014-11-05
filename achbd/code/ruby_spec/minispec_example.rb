#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
# minispec
# 
# Very minimal set of features to support specs like this:
# 
# context "Array" do 
#   specify "should respond to new" do
#     Array.new.should == [] 
#   end
# end

class PositiveSpec 
  def initialize(obj)
    @obj = obj
  end

  def ==(other) 
    if @obj != other
      raise Exception.new("equality expected")
    end
  end
end

class NegativeSpec
  def initialize(obj)
    @obj = obj 
  end

  def ==(other)
    if @obj == other
      raise Exception.new("inequality expected") 
    end
  end
end

class Object
  def should
    PositiveSpec.new(self) 
  end

  def should_not 
    NegativeSpec.new(self)
  end
end

def specify(msg)
  print '.'
  begin
    yield 
  rescue Exception => e
    print msg 
    print " FAILED\n"
    print e.message 
    print "\n"
  end
end
def context(msg)
  yield
end

