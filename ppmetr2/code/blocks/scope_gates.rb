#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
v1 = 1                  
class MyClass        # SCOPE GATE: entering class
  v2 = 2                
  local_variables    # => ["v2"]
  def my_method      # SCOPE GATE: entering def
    v3 = 3
    local_variables
  end                # SCOPE GATE: leaving def
  local_variables    # => ["v2"]
end                  # SCOPE GATE: leaving class

obj = MyClass.new
obj.my_method        # => [:v3]
local_variables      # => [:v1, :obj]

require_relative "../test/assertions"
assert_equals [:v3], obj.my_method
assert_equals [:v1, :obj], local_variables
