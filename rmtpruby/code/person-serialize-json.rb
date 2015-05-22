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
    {
      "json_class" => self.class.name,
      "data" => { "name" => name, "age" => age }
    }.to_json
  end

  def self.json_create(object)
    data = object["data"]
    new(data["name"], data["age"])
  end
end

person = Person.new("Alice", 32)

json = person.to_json
# => "{\"json_class\":\"Person\",\"data\":{\"name\":\"Alice\",\"age\":32}}"

person = JSON.load(json)
person.class
# => Person
person.name
# => "Alice"
person.age
# => 32

