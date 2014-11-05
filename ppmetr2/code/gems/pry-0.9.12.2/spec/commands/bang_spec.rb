#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'helper'

describe "!" do
  before do
    @t = pry_tester
  end

  it 'should correctly clear the input buffer ' do
    eval_str = unindent(<<-STR)
      def hello
        puts :bing
    STR

    @t.process_command '!', eval_str
    @t.last_output.should =~ /Input buffer cleared!/

    eval_str.should == ''
  end
end
