#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'
java_import java.lang.Runnable

class Foo
  include Runnable 

  def run
    puts "foo"
  end
end

callable = java.util.concurrent.Executors.callable(Foo.new)
callable.call

callable = java.util.concurrent.Executors.callable do
  puts "foo"
end

callable.call

myproc = Proc.new { puts "foo" }
callable = java.util.concurrent.Executors.callable(myproc)

callable.call

java_import 'CollectionDemo'

CollectionDemo.do_collection_stuff do |name, *args|
  puts "method #{name} called with args #{args}"
  case name
  when :size; return 0
  when :add; return false;
  end
end
# "method size called with args []"
# "method add called with args ["foo"]"
