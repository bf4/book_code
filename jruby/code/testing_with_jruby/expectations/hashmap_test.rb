#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---

require 'rubygems'
require 'expectations'

require 'java'

java_import java.util.HashMap

Expectations do 
  expect true do 
    HashMap.new.isEmpty
  end

  expect false do 
    h = HashMap.new
    h.put("hello", "world")
    h.isEmpty
  end

  expect "world" do 
    h = HashMap.new
    h.put("hello", "world")
    h.get("hello")
  end

  expect NativeException do 
    HashMap.new.entrySet.iterator.next
  end
end
