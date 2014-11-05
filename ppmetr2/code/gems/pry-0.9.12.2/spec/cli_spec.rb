#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'helper'

describe Pry::Hooks do
  before do
    Pry::CLI.reset
  end

  describe "parsing options" do
    it 'should raise if no options defined' do
      lambda { Pry::CLI.parse_options(["--nothing"]) }.should.raise Pry::CLI::NoOptionsError
    end
  end

  describe "adding options" do
    it "should be able to add an option" do
      run = false

      Pry::CLI.add_options do
        on :optiontest, "A test option" do
          run = true
        end
      end.parse_options(["--optiontest"])

      run.should == true
    end

    it "should be able to add multiple options" do
      run = false
      run2 = false

      Pry::CLI.add_options do
        on :optiontest, "A test option" do
          run = true
        end
      end.add_options do
        on :optiontest2, "Another test option" do
          run2 = true
        end
      end.parse_options(["--optiontest", "--optiontest2"])

      run.should == true
      run2.should == true
    end

  end

  describe "processing options" do
    it "should be able to process an option" do
      run = false

      Pry::CLI.add_options do
        on :optiontest, "A test option"
      end.process_options do |opts|
        run = true if opts.present?(:optiontest)
      end.parse_options(["--optiontest"])

      run.should == true
    end

    it "should be able to  process multiple options" do
      run = false
      run2 = false

      Pry::CLI.add_options do
        on :optiontest, "A test option"
        on :optiontest2, "Another test option"
      end.process_options do |opts|
        run = true if opts.present?(:optiontest)
      end.process_options do |opts|
        run2 = true if opts.present?(:optiontest2)
      end.parse_options(["--optiontest", "--optiontest2"])

      run.should == true
      run2.should == true
    end

  end
end
