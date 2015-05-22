#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "json"

class Person
  attr :name, :age

  def initialize(name, age)
    @name = name
    @age  = age
  end

  def to_json(*)
    { "name" => name, "age" => age }.to_json
  end
end

person = Person.new("Alice", 32)
person.to_json
# => "{\"name\":\"Alice\",\"age\":32}"

person = Person.new("Alice", 32)
[ 14, 42, person ].to_json
# => "[14,42,{\"name\":\"Alice\",\"age\":32}]"
