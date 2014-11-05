#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'helper'

describe "exit" do
  it 'should pop a binding with exit' do
    pry_tester(:outer).simulate_repl do |t|
      t.eval 'cd :inner'
      t.eval('self').should == :inner
      t.eval 'exit'
      t.eval('self').should == :outer
      t.eval 'exit-all'
    end
  end

  it 'should break out of the repl loop of Pry instance when binding_stack has only one binding with exit' do
    pry_tester(0).simulate_repl do |t|
      t.eval 'exit'
    end.should == nil
  end

  it 'should break out of the repl loop of Pry instance when binding_stack has only one binding with exit, and return user-given value' do
    pry_tester(0).simulate_repl do |t|
      t.eval 'exit :john'
    end.should == :john
  end

  it 'should break out the repl loop of Pry instance even after an exception in user-given value' do
    pry_tester(0).simulate_repl do |t|
      proc {
        t.eval 'exit = 42'
      }.should.raise(SyntaxError)
      t.eval 'exit'
    end.should == nil
  end
end
