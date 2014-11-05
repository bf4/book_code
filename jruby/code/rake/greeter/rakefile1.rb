#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
desc "Compiles the code"
task :compile

desc "Compiles the test code"
task :compile_test => :compile

desc "Runs the tests"
task :test => :compile_test

desc "Creates the jar file"
task :jar => :test

task :default => :jar
