#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
#--------------------------------------
# HighLine command-line input library
#
# Copyright (C) 2005 Ryan Leavengood
#
# Released under the Ruby license
#--------------------------------------


class String
  def pad_if_needed
    self[-1].chr != ' ' ? self + ' ' : self
  end
end

class HighLine
  attr_accessor :io_out, :io_in
  def initialize(io_out=$stdout, io_in=$stdin)
    @io_out, @io_in = io_out, io_in
  end

  def ask(question, default=nil)
    q = question.pad_if_needed
    q += "[#{default}] " if default
    answer = validation_loop(q) do |input|
      input.size > 0 or default
    end
    answer.size > 0 ? answer : default
  end

  def ask_if?(question)
    answer = validation_loop(question.pad_if_needed+'(y,n) ') do |input|
      %w(y n yes no).include?(input.downcase)
    end
    answer.downcase[0,1] == 'y'
  end

  def ask_int(question, range=nil)
    validation_loop(question) do |input|
      input =~ /\A\s*-?\d+\s*\Z/ and (not range or range.member?(input.to_i))
    end.to_i
  end

  def ask_float(question, range=nil)
    validation_loop(question) do |input|
      input =~ /\A\s*-?\d+(.\d*)?\s*\Z/ and
        (not range or range.member?(input.to_f))
    end.to_f
  end

  def header(title)
    dashes = '-'*(title.length+4)
    io_out.puts(dashes)
    io_out.puts("| #{title} |")
    io_out.puts(dashes)
  end

  def list(items, prompt=nil)
    items.each_with_index do |item, i|
      @io_out.puts "#{i+1}. #{item}"
    end
    valid_range = 1..items.length
    prompt = "Please make a selection: " unless prompt
    answer = validation_loop(prompt) do |input|
      valid_range.member?(input.to_i)
    end
    # Though the list is shown using a 1-indexed list, return 0-indexed
    return answer.to_i-1
  end

  def validation_loop(prompt)
    loop do
      @io_out.print prompt.pad_if_needed
      answer = @io_in.gets
      if answer
        answer.chomp!
        if yield answer
          return answer
        end
      end
    end
  end
end


# Unit Tests
if $0 == __FILE__
  class MockIO
    attr_accessor :output, :input

    def initialize
      reset
    end

    def reset
      @index = 0
      @input=nil
      @output=''
    end

    def print(*a)
      @output << a.join('')
    end

    def puts(*a)
      if a.size > 1
        @output << a.join("\n")
      else
        @output << a[0] << "\n"
      end
    end

    def gets
      if @input.kind_of?(Array)
        @index += 1
        @input[@index-1]
      else
        @input
      end
    end
  end

  require 'test/unit'

  class TC_HighLine < Test::Unit::TestCase
    def initialize(name)
      super(name)
      @mock_io = MockIO.new
      @highline = HighLine.new(@mock_io, @mock_io)
    end


    def setup
      @mock_io.reset
    end

    def test_ask
      question = 'Am I the coolest?'
      @mock_io.input = [nil, '', "\n", "yes\n"]
      assert_equal(@mock_io.input[-1].chomp, @highline.ask(question))
      assert_equal((question+' ')*4, @mock_io.output)
    end

    def test_ask_default
      question = 'Where are you from? '
      default = 'Florida'
      @mock_io.input = [nil, "\n"]
      assert_equal(default, @highline.ask(question, default))
      assert_equal((question+"[#{default}] ")*2, @mock_io.output)
    end

    def test_ask_if
      question = 'Is Ruby the best programming language? '
      @mock_io.input = [nil, "0\n", "blah\n", "YES\n"]
      assert_equal(true, @highline.ask_if?(question))
      assert_equal((question+'(y,n) ')*4, @mock_io.output)
    end

    def test_ask_int
      question = 'Give me a number:'
      @mock_io.input = [nil, '', "\n", ' ', "blah\n", "  -4   \n"]
      assert_equal(-4, @highline.ask_int(question))
      assert_equal((question+' ')*6, @mock_io.output)
      @mock_io.reset
      @mock_io.input = [nil, '', "\n", ' ', "blah\n", "3604\n"]
      assert_equal(3604, @highline.ask_int(question))
      assert_equal((question+' ')*6, @mock_io.output)
    end

    def test_ask_int_range
      question = 'How old are you?'
      @mock_io.input = [nil, '', "\n", ' ', "blah\n", "106\n", "28\n"]
      assert_equal(28, @highline.ask_int(question, 0..105))
      assert_equal((question+' ')*7, @mock_io.output)
    end

    def test_ask_float
      question = 'Give me a floating point number:'
      @mock_io.input = [nil, '', "\n", ' ', "blah\n", "  -4.3   \n"]
      assert_equal(-4.3, @highline.ask_float(question))
      assert_equal((question+' ')*6, @mock_io.output)
      @mock_io.reset
      @mock_io.input = [nil, '', "\n", ' ', "blah\n", "560\n"]
      assert_equal(560.0, @highline.ask_float(question))
      assert_equal((question+' ')*6, @mock_io.output)
    end

    def test_ask_float_range
      question = 'Give me a floating point number between 5.0 and 13.5:'
      @mock_io.input = [ nil, '', "\n", ' ', "blah\n", "  -4.3   \n", "4.9\n",
                         "13.6\n", "7.55\n" ]
      assert_equal(7.55, @highline.ask_float(question, 5.0..13.5))
      assert_equal((question+' ')*9, @mock_io.output)
    end

    def test_header
      title = 'HighLine Manual'
      @highline.header(title)
      output = "-------------------\n| HighLine Manual |\n-------------------\n"
      assert_equal(output, @mock_io.output)
    end

    def test_list
      items = ['Ruby','Python','Perl']
      prompt = 'Please choose your favorite programming language: '
      @mock_io.input = [nil, "0\n", "blah\n", "4\n", "1\n"]
      assert_equal(0, @highline.list(items, prompt))
      assert_equal("1. Ruby\n2. Python\n3. Perl\n#{prompt * 5}",
                   @mock_io.output)
    end
  end
end

