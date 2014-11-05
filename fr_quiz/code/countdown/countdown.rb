#!/usr/bin/ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

#######################################################################
# Countdown Solver Experiments (Main File)
# (c) 2004 Brian Schröder
# http:://ruby.brian-schroeder.de/
#######################################################################
# This code is under GPL
#######################################################################
#
# Additional files required/proposed:
# - countdown-memoized.rb
# - countdown-recursive.rb

USAGE = "countdown.rb [options] target (numbers...)
    --all      -a   Report all occurrences
    --integral -i   Report only solutions that create only integral subsolutions
                    The integral version is a lot faster than the
                    fractional version. (For six cards ~ factor two)

                    Default is to allow all solutions.
    --quiet    -q   Don't report partitial solutions
    --memoized -m   Use memoization to speed up the search. This will eat lots
                    of ram and if there is no more ram,
                    speed will even be worse than without memoization.
    --recursive -r  Use simple recursive brute force search. Will use only a
                    constant amount of memory, but calculates a lot of results
                    multiple times."

################################################################################
# Extend builtin classes with general functionality

# Extending Array with simple set functions
class Array
  # Returns each true partition (containing no empty set) exactly once.
  def each_partition
    return nil if empty?
    head, *tail = *self
    tail._each_partition do | subset, rest |
      yield [subset.unshift(head), rest] unless rest.empty?
    end
  end

  protected
  # Returns each partition twice, as (s1, s2) and (s2, s1)
  def _each_partition
    if empty?
      yield([], [])
      return nil
    end
    head, *tail = *self
    tail._each_partition do | s1, s2 |
      yield([head] + s1, s2) 
      yield(s1, [head] + s2)
    end
  end
end

class Numeric
  # Hacking Numeric, to make the program simpler
  def value() self end
end

################################################################################
# Our representation of a solution

# Build a term tree using these nodes
#
# Saves valued results, so multiple evalations are fast.
class Term
  attr_reader :left, :right, :operation
  
  def initialize(left, right, operation)
    @left = left
    @right = right
    @operation = operation
  end

  def to_s
    "(#{@left} #{operation} #{@right})"
  end

  def value
    @value || (@value = (@left.value).send(@operation, (@right.value)))
  end

  def ==(o)
    return false unless o.is_a?Term
    to_s == o.to_s
  end
end

################################################################################

# Search all possible terms for the ones that fit best.

# Systematically create all terms over all subsets of the set of numbers in
# source, and find the one that is closest to target.
#
# Returns the solution that is closest to the target.
#
# If a block is given, calls the block each time a better or equal solution
# is found.
#
# As a heuristic to guide the search, sort the numbers ascending.
def solve_countdown(target, source, use_module)
  source = source.sort_by{|i|-i}
  best = nil
  best_distance = 1.0/0.0
  use_module::each_term_over(source) do | term |
    distance = (term.value - target).abs
    if distance <= best_distance
      best_distance = distance
      best = term        
      yield best if block_given?
    end
  end
  return best
end


################################################################################
# User Interface

require 'optparse'

class CountdownOptions < OptionParser
  attr_reader :quiet, :show_all, :mode, :method, :source, :target
  
  def initialize
    super
    # Defaults
    @mode = :Fraction
    @method = :Recursive

    # Switches
    on("--all", "-a")       do @show_all = true end
    on("--integral", "-i")  do @mode = :Integral end
    on("--recursive", "-r") do @method = :Recursive end
    on("--memoized", "-m")  do @method = :Memoized end
    on("--quiet", "-q")     do @quiet = true end
    
    @target, *@source = *parse(ARGV).map{|i|i.to_i}
    if @mode != :Integral
      @target = @target.to_f
      @source = @source.map { | e | e.to_f }
    end
    unless @source and source.length > 0
      raise OptionParser::MissingArgument, "Not enough arguments"
    end
  end
end

if $0 == __FILE__
  begin
    opts = CountdownOptions.new
    
    require 'countdown-recursive' rescue $stderr.puts "Recursive brute force " +
                                                      "library not found, " +
                                                      "recursive solution " +
                                                      "not available."
    require 'countdown-memoized' rescue $stderr.puts "Memoization library " +
                                                     "not found, memoization " +
                                                     "not available."
    
    solutions = []
    best = solve_countdown( opts.target, opts.source,
                            Object.const_get(opts.method).const_get(opts.mode)
                            ) do | best |
      $stderr.puts "Best so far: #{best} = #{best.value}" unless opts.quiet
      if best.value == opts.target
        solutions << best
        break best unless opts.show_all
      end
    end
    if solutions.empty? or !opts.show_all
      puts "Best approximation for combinations of #{opts.source.inspect} " +
           "to yield #{opts.target}:", "#{best} = #{best.value}"
    else
      puts "Solutions for combinations of #{opts.source.inspect} " +
           "to yield #{opts.target}:", solutions.uniq
    end
  rescue OptionParser::ParseError
    puts "Usage", USAGE
  end
end
