#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

require "optparse"
require "date"

class HighLine
  class Answer
    # Create an instance of HighLine::Answer.
    def initialize( type )
      @type = type
      
      @ask_on_error = "?  "
      @member       = nil
      @validate     = nil
      @responses     = Hash.new
      
      yield self if block_given?

      @responses = { :ambiguous_completion =>
                         "Ambiguous choice.  " +
                         "Please choose one of #{@type.inspect}.",
                     :failed_tests         =>
                         "Your answer must be a member of " +
                         "#{@member.inspect}.",
                     :invalid_type         =>
                         "You must enter a valid #{@type}.",
                     :not_valid            =>
                         "Your answer isn't valid " +
                         "(#{@validate.inspect}).'" }.merge(@responses)
    end
    
    attr_accessor :ask_on_error, :member, :validate
    attr_reader :responses
    
    def convert( string )
      if @type.nil?
        string
      elsif [Float, Integer, String].include?(@type)
        Kernel.send(@type.to_s.to_sym, string)
      elsif @type == Symbol
        string.to_sym
      elsif @type == Regexp
        Regexp.new(string)
      elsif @type.is_a?(Array)
        @type.extend(OptionParser::Completion)
        @type.complete(string).last
      elsif [Date, DateTime].include?(@type)
        @type.parse(string)
      elsif @type.is_a?(Proc)
        @type[string]
      end
    end
    
    def accept?( answer_object )
      @member.nil? or @member.member?(answer_object)
    end

    def valid?( string )
      @validate.nil? or string =~ @validate
    end
  end
end
