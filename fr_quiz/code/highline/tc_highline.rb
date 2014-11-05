#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

require "test/unit"

require "highline"
require "stringio"

class TestHighLine < Test::Unit::TestCase
  def setup
    @input    = StringIO.new
    @output   = StringIO.new
    @terminal = HighLine.new(@input, @output)  
  end
  
  def test_agree
    @input << "y\nyes\nYES\nHell no!\n"
    @input.rewind

    assert_equal(true, @terminal.agree("Yes or no?  "))
    assert_equal(true, @terminal.agree("Yes or no?  "))
    assert_equal(true, @terminal.agree("Yes or no?  "))
    assert_equal(false, @terminal.agree("Yes or no?  "))
  end
  
  def test_ask
    name = "James Edward Gray II"
    @input << name << "\n"
    @input.rewind

    assert_equal(name, @terminal.ask("What is your name?  "))
  end
  
  def test_membership
    @input << "112\n-541\n28\n"
    @input.rewind

    answer = @terminal.ask("Tell me your age.", Integer) do |q|
      q.member = 0..105
    end
    assert_equal(28, answer)
  end
  
  def test_reask
    number = 61676
    @input << "Junk!\n" << number << "\n"
    @input.rewind

    answer = @terminal.ask("Favorite number?  ", Integer)
    assert_kind_of(Integer, number)
    assert_instance_of(Fixnum, number)
    assert_equal(number, answer)
    assert_equal( "Favorite number?  " +
                  "You must enter a valid Integer.\n" +
                  "?  ", @output.string )

    @input.rewind
    @output.truncate(@output.rewind)

    answer = @terminal.ask("Favorite number?  ", Integer) do |q|
      q.ask_on_error             = :question
      q.responses[:invalid_type] = "Not a valid number!"
    end
    assert_kind_of(Integer, number)
    assert_instance_of(Fixnum, number)
    assert_equal(number, answer)
    assert_equal( "Favorite number?  " +
                  "Not a valid number!\n" +
                  "Favorite number?  ", @output.string )

    @input.truncate(@input.rewind)
    @input << "gen\ngene\n"
    @input.rewind
    @output.truncate(@output.rewind)

    answer = @terminal.ask("Select a mode:  ", [:generate, :gentle])
    assert_instance_of(Symbol, answer)
    assert_equal(:generate, answer)
    assert_equal( "Select a mode:  " + 
                  "Ambiguous choice.  " + 
                  "Please choose one of [:generate, :gentle].\n" + 
                  "?  ", @output.string )
  end
  
  def test_say
    @terminal.say("This will have a newline.")
    assert_equal("This will have a newline.\n", @output.string)

    @output.truncate(@output.rewind)

    @terminal.say("This will also have one newline.\n")
    assert_equal("This will also have one newline.\n", @output.string)

    @output.truncate(@output.rewind)

    @terminal.say("This will not have a newline.  ")
    assert_equal("This will not have a newline.  ", @output.string)
  end

  def test_type_conversion
    number = 61676
    @input << number << "\n"
    @input.rewind

    answer = @terminal.ask("Favorite number?  ", Integer)
    assert_kind_of(Integer, answer)
    assert_instance_of(Fixnum, answer)
    assert_equal(number, answer)
    
    @input.truncate(@input.rewind)
    number = 1_000_000_000_000_000_000_000_000_000_000
    @input << number << "\n"
    @input.rewind

    answer = @terminal.ask("Favorite number?  ", Integer)
    assert_kind_of(Integer, answer)
    assert_instance_of(Bignum, answer)
    assert_equal(number, answer)

    @input.truncate(@input.rewind)
    number = 10.5002
    @input << number << "\n"
    @input.rewind

    answer = @terminal.ask( "Favorite number?  ",
                            lambda { |n| n.to_f.abs.round } )
    assert_kind_of(Integer, answer)
    assert_instance_of(Fixnum, answer)
    assert_equal(11, answer)

    @input.truncate(@input.rewind)
    animal = :dog
    @input << animal << "\n"
    @input.rewind

    answer = @terminal.ask("Favorite animal?  ", Symbol)
    assert_instance_of(Symbol, answer)
    assert_equal(animal, answer)

    @input.truncate(@input.rewind)
    @input << "6/16/76\n"
    @input.rewind

    answer = @terminal.ask("Enter your birthday.", Date)
    assert_instance_of(Date, answer)
    assert_equal(16, answer.day)
    assert_equal(6, answer.month)
    assert_equal(76, answer.year)

    @input.truncate(@input.rewind)
    pattern = "^yes|no$"
    @input << pattern << "\n"
    @input.rewind

    answer = @terminal.ask("Give me a pattern to match with:  ", Regexp)
    assert_instance_of(Regexp, answer)
    assert_equal(/#{pattern}/, answer)

    @input.truncate(@input.rewind)
    @input << "gen\n"
    @input.rewind

    answer = @terminal.ask("Select a mode:  ", [:generate, :run])
    assert_instance_of(Symbol, answer)
    assert_equal(:generate, answer)
  end
  
  def test_validation
    @input << "system 'rm -rf /'\n105\n0b101_001\n"
    @input.rewind

    answer = @terminal.ask("Enter a binary number:  ") do |q|
      q.validate = /\A(?:0b)?[01_]+\Z/
    end
    assert_equal("0b101_001", answer)
  end
end
