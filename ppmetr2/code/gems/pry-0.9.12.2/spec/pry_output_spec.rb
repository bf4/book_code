#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'helper'

describe Pry do
  describe "output failsafe" do
    after do
      Pry.config.print = Pry::DEFAULT_PRINT
    end

    it "should catch serialization exceptions" do
      Pry.config.print = lambda { |*a| raise "catch-22" }

      lambda {
        mock_pry("1")
      }.should.not.raise
    end

    it "should display serialization exceptions" do
      Pry.config.print = lambda { |*a| raise "catch-22" }

      mock_pry("1").should =~ /\(pry\) output error: #<RuntimeError: catch-22>/
    end

    it "should catch errors serializing exceptions" do
      Pry.config.print = lambda do |*a|
        raise Exception.new("catch-22").tap{ |e| class << e; def inspect; raise e; end; end }
      end

      mock_pry("1").should =~ /\(pry\) output error: failed to show result/
    end
  end

  describe "DEFAULT_PRINT" do
    it "should output the right thing" do
      mock_pry("[1]").should =~ /^=> \[1\]/
    end

    it "should include the =>" do
      accumulator = StringIO.new
      Pry.config.print.call(accumulator, [1])
      accumulator.string.should == "=> \[1\]\n"
    end

    it "should not be phased by un-inspectable things" do
      mock_pry("class NastyClass; undef pretty_inspect; end", "NastyClass.new").should =~ /#<.*NastyClass:0x.*?>/
    end
  end

  describe "color" do
    before do
      Pry.color = true
    end

    after do
      Pry.color = false
    end

    it "should colorize strings as though they were ruby" do
      accumulator = StringIO.new
      Pry.config.print.call(accumulator, [1])
      accumulator.string.should == "=> [\e[1;34m1\e[0m]\e[0m\n"
    end

    it "should not colorize strings that already include color" do
      f = Object.new
      def f.inspect
        "\e[1;31mFoo\e[0m"
      end
      accumulator = StringIO.new
      Pry.config.print.call(accumulator, f)
      # We add an extra \e[0m to prevent color leak
      accumulator.string.should == "=> \e[1;31mFoo\e[0m\e[0m\n"
    end
  end

  describe "output suppression" do
    before do
      @t = pry_tester
    end
    it "should normally output the result" do
      mock_pry("1 + 2").should == "=> 3\n\n"
    end

    it "should not output anything if the input ends with a semicolon" do
      mock_pry("1 + 2;").should == "\n"
    end

    it "should output something if the input ends with a comment" do
      mock_pry("1 + 2 # basic addition").should == "=> 3\n\n"
    end

    it "should not output something if the input is only a comment" do
      mock_pry("# basic addition").should == "\n"
    end
  end
end
