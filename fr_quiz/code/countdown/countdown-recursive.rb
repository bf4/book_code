#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
#######################################################################
# Countdown Solver Experiments (Brute Force addon)
# (c) 2004 Brian Schröder
# http:://ruby.brian-schroeder.de/
#######################################################################
# This code is under GPL
#######################################################################

module Recursive

  # Allow fractional results
  module Fraction
    # Call the given block for each term that can be constructed over a set 
    # of numbers.
    #
    # Recursive implementation, that calls a block each time a new term has 
    # been stitched together.  Returns each term multiple times.
    #
    # This may be a bit slow, because it zips up through the whole callstack
    # each time a new term is created.
    #
    # It was a bit more compact when I used arrays to iterate, but on the other
    # hand now I'm pruning some of the more stupid operations.
    def Fraction.each_term_over(source)
      if source.length == 1
        yield source[0]
      else
        source.each_partition do | p1, p2 |
          each_term_over(p1) do | op1 |
            yield op1
            each_term_over(p2) do | op2 |
              yield op2
              if op2.value != 0.0
                yield Term.new(op1, op2, :+) 
                yield Term.new(op1, op2, :-)
                yield Term.new(op1, op2, :'/') if op2.value != 1.0
              end
              if op1.value != 0.0
                yield Term.new(op2, op1, :-)
                if op1.value != 1.0
                  yield Term.new(op2, op1, :'/')
                  yield Term.new(op1, op2, :*) if op2.value != 0.0 and
                                                  op2.value != 1.0
                end
              end
            end
          end
        end
      end
    end
  end
end


module Recursive
  # Allow only integral results
  module Integral
    # Call the given block for each term that can be constructed over a set
    # of numbers.
    #
    # Recursive implementation that calls a block each time a new term has been
    # stitched together. Returns each term multiple times.
    #
    # This version checks that only integral results may result.
    #
    # Here I explicitly coded the operators, because there is not
    # much redundance.
    #
    # This may be a bit slow, because it zips up through the whole callstack
    # each time a new term is created.

    def Integral.each_term_over(source)
      if source.length == 1
        yield source[0]
      else
        source.each_partition do | p1, p2 |
          each_term_over(p1) do | op1 |
            yield op1
            each_term_over(p2) do | op2 |
              yield op2
              if op2.value != 0
                yield Term.new(op1, op2, :+) 
                yield Term.new(op1, op2, :-)
                yield Term.new(op1, op2, :'/') if op2.value != 1 and
                                                  op1.value % op2.value == 0
              end
              if op1.value != 0
                yield Term.new(op2, op1, :-)
                if op1.value != 1
                  yield Term.new(op2, op1, :'/') if op2.value % op1.value == 0
                  yield Term.new(op1, op2, :*) if op2.value != 0 and
                                                  op2.value != 1
                end
              end
            end
          end
        end
      end
    end
  end
end

