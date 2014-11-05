#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'helper'

describe "show-input" do
  before do
    @t = pry_tester
  end

  it 'should correctly show the current lines in the input buffer' do
    eval_str = unindent(<<-STR)
      def hello
        puts :bing
    STR

    @t.process_command 'show-input', eval_str
    @t.last_output.should =~ /\A\d+: def hello\n\d+:   puts :bing/
  end
end
