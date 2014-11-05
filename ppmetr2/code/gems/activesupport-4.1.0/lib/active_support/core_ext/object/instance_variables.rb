#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Object
  # Returns a hash with string keys that maps instance variable names without "@" to their
  # corresponding values.
  #
  #   class C
  #     def initialize(x, y)
  #       @x, @y = x, y
  #     end
  #   end
  #
  #   C.new(0, 1).instance_values # => {"x" => 0, "y" => 1}
  def instance_values
    Hash[instance_variables.map { |name| [name[1..-1], instance_variable_get(name)] }]
  end

  # Returns an array of instance variable names as strings including "@".
  #
  #   class C
  #     def initialize(x, y)
  #       @x, @y = x, y
  #     end
  #   end
  #
  #   C.new(0, 1).instance_variable_names # => ["@y", "@x"]
  def instance_variable_names
    instance_variables.map { |var| var.to_s }
  end
end
