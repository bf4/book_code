#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
#
# HighLine::Dave is a high-level line-oriented user input helper.
#
# It's somewhat similar to Francis Hwang's EasyPrompt, and takes some
# ideas from OptParse.
#
# See HighLine::Dave::Prompt for documentation.
#
# A response to Ruby Quiz #29 - HighLine [ruby-talk:139341]
#
# Author: Dave Burt <dave at burt.id.au>
#
# Created: 26 Apr 2005
# Last Updated: 28 Apr 2005
#

# Submitted by:  Dave Burt  <dave@burt.id.au>

module HighLine
module Dave

#
# A Prompt is a question to ask the user. It can include a default value, a
# cast to a particular class, restriction to a list of options, and other
# validation. The number of retries allowed and whether to display any default
# can also be specified.
#
# These are a Prompt object's attributes:
#   prompt, default, cast, validation, retries, options, display_default
#
# Prompt.ask will create a Prompt object, ask it, and return the response.
#
# If you want to reuse a Prompt object, you can create one, and ask it any
# time.
#
class Prompt

  attributes = :prompt, :default, :cast, :validation, :retries, :options,
               :display_default
  #
  # All attributes have writer methods
  #
  attr_writer *attributes
  def validation=(v)
    if v.respond_to? :to_proc
      @validation = v.to_proc
    elsif v.respond_to? :===
      @validation =
        proc do |x|
          v === x or puts "#{x.inspect} doesn't match #{v.inspect}"
        end
    else
      raise TypeError
    end
  end
  def options=(o, h = {})
    if o.is_a? OptionList
      @options = o
    else
      @options = OptionList.new(o.to_a, h)
    end
    @cast = @options.options.first.class if @cast.nil?
  end
  def cast=(c)
    @cast = c
    if c == TrueClass then     @default = true
    elsif c == FalseClass then @default = false
    end
  end
  def default=(d)
    @default = d
    @cast = d.class if @cast.nil?
  end

  #
  # Each attribute has a reader method which, if parameters are passed
  # to it, becomes a writer
  #
  attributes.each do |attr|
    define_method attr do |*args|
      if args.empty?
        instance_eval "@#{attr}"
      else
        send "#{attr}=", *args
      end
    end
  end
  
  #
  # Create a Prompt
  #
  # Options can be entered in three ways:
  #  1) passed as named arguments like so: new("A number?", :cast => Numeric)
  #  2) inferred from their class: new("A number, 1-3?", Numeric, 1..3)
  #  3) assigned as properties in a block:
  #     new("A word with foo in it?") do
  #       validation /foo/i
  #       default "Foo"
  #     end
  #
  # Inference from arguments' class works like this:
  #  Class -> cast
  #  Array, OptionList -> options
  #  Proc, Method, Range, Regexp -> validation
  #  String, Numeric, TrueClass, FalseClass -> default (also affects cast)
  #
  def initialize(prompt = "?", *args, &block)

    # attribute defaults
    @retries = (1.0/0.0) #infinity
    @display_default = true
    @prompt = prompt.to_s

    args.each do |arg|
      case arg
      when Hash
        arg.each_pair do |option, value|
          if respond_to? "#{option}="
            send("#{option}=", value) 
          else
            raise ArgumentError.new("Invalid option: #{option}")
          end
        end
      when Class
        self.cast = arg
      when Array, OptionList
        self.options = arg
      when Proc, Method, Range, Regexp
        self.validation = arg
      when String, Numeric, TrueClass, FalseClass
        self.default = arg
      end
    end

    instance_eval &block if block
  end

  #
  # A string to show the default to the user
  #
  def default_prompt
    if @default != nil and @display_default
      '[' +
      if @cast == TrueClass
        "Yn"
      elsif @cast == FalseClass
        "yN"
      elsif @cast <= Array
        @default.join(', ')
      else
        @default.to_s
      end \
      + '] '
    else
      ""
    end
  end

  #
  # Prompt the user and get the required result
  #
  # Return nil only if no acceptable response was entered and retries ran out
  #
  def ask

    # retry loop
    0.upto(@retries) do

      # prompt user
      print prompt + " " + default_prompt

      # get input
      input = gets.chomp.strip

      # on blank, default or retry
      if input.empty?
        if @default.nil? then next
        else return @default
        end
      end

      # cast input as required
      input =
      if @options
        @options.complete(input) {|inp, opt| opt } or
          raise "Choose from #{@options.options.join(', ')}"
      elsif @cast.nil? or @cast == String
        input
      elsif @cast <= Float
        Float(input)
      elsif @cast <= Integer
        Integer(input)
      elsif @cast <= Numeric
        if input =~ /[.eE]/ then Float(input)
        else Integer(input)
        end
      elsif @cast <= Array
        input.split /\s*[,\s]\s*/
      elsif @cast == TrueClass or @cast == FalseClass
        case input
        when /y|yes|t|true/i: true
        when /n|no|f|false/i: false
        else next
        end
      else
        @cast.new(input) # good luck with this one
      end \
      rescue begin puts $!; next end # offer any error to the user

      # validate
      next if @validation and not @validation.call(input) \
        rescue begin puts $!; next end # offer any error to the user

      return input
    end

    nil # failure to get valid input
  end

  #
  # Create a Prompt and ask it, with a function-like syntax.
  # e.g. Prompt.ask "Give me a string here:"
  # Any block given is used for validation.
  #
  def self.ask(prompt = "?", *args, &validation)
    Prompt.new(prompt, validation, *args).ask
  end

  #
  # A list of options that are acceptable entries, and (optionally) aliases
  # to other options.
  # It's a list and a map whose elements all point to elements of the list.
  # The Completion mixin allows it to return canonical options from
  # partially entered aliases.
  #
  class OptionList
    include Enumerable
    require 'optparse'
    include OptionParser::Completion
    attr_accessor :options, :aliases
    def initialize(options = [], aliases = {})
      @options = options.uniq
      @aliases =
        if aliases.empty? and options.last.is_a?(Hash)
          options.pop
        else
          aliases
        end.delete_if do |k, v|
          not options.include? v
        end
    end
    def each
      options.each {|el| yield el, el }
      aliases.each {|k, v| yield k, v }
    end
    def to_hash
      inject({}) {|result, pair| result[pair.first] = pair.last; result }
    end
    def inspect
      options_inspect = @options.inspect[1...-1]
      aliases_inspect = @aliases.inspect[1...-1]
      comma = @options.empty? || @aliases.empty? ? '' : ', '
      '<OptionList: ' + options_inspect + comma + aliases_inspect + '>'
    end
  end
end

end # module Dave
end # module HighLine

Prompt = HighLine::Dave::Prompt

#
# Add Prompt.ask to Object unless the method is already defined
#
unless defined? ask
  def ask(*args, &block)
    Prompt.ask(*args, &block)
  end
end


=begin

# Example usage from the Quiz
age = ask("What is your age?", Integer, 0..105 )
num = ask('Enter a binary number.') {|s| not s =~ /[^01]/ }.to_i(2)
if ask("Would you like to continue?", TrueClass) # ... 

# Example usage from EasyPrompt documentation
irb(main):004:0> lname = ask("What's your last name?", "Doe")
What's your last name? [Doe] 
=> "Doe"
irb(main):005:0> ok = ask("Is your name #{ fname } #{ lname }?", TrueClass)
Is your name John Doe? [Yn]
=> true 

# Extra examples
ask
ask("How many strikes will be allowed?", 3, 0..(1.0/0.0))
ask("Give me a word with "foo" in it:", /foo/)
ask("Give me a number divisible by 3:", Integer) {|i| i % 3 == 0 }
ask("Give me three or more numbers:", Array) do |x|
  x.each {|n| Float(n) }
    x.size >= 3 or puts "I need more things than that!"
end.map {|n| n.to_f }

=end

