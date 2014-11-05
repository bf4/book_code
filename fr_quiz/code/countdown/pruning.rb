#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

class Solver
  class Term
    attr_reader :value, :mask

    def initialize(value, mask, op = nil, left = nil, right = nil)
      @value = value
      @mask = mask
      @op = op
      @left = left
      @right = right
    end

    def to_s
      return @value.to_s unless @op
      "(#@left #@op #@right)"
    end
  end

  def initialize(sources, target)
    printf "%s -> %d\n", sources.inspect, target
    @target = target
    @new_terms = []
    @num_sources = sources.size
    @num_hashes = 1 << @num_sources

    # the hashes are used to check for duplicate terms
    # (terms that have the same value and use the same
    # source numbers)
    @term_hashes = Array.new(@num_hashes) { {} }

    # enter the source numbers as (simple) terms
    sources.each_with_index do |value, index|

      # each source number is represented by one bit in the bit mask
      mask = 1 << index
      p mask
      p value
      term = Term.new(value, mask)
      @new_terms << term
      @term_hashes[mask][value] = term
    end
  end
end



class Solver
  def run
    collision = 0
    best_difference = 1.0/0.0
    next_new_terms = [nil]
    until next_new_terms.empty?
      next_new_terms = []

      # temporary hashes for terms found in this iteration
      # (again to check for duplicates)
      new_hashes = Array.new(@num_hashes) { {} }

      # iterate through all the new terms (those that weren't yet used
      # to generate composite terms)
      @new_terms.each do |term|

        # iterate through the hashes and find those containing terms
        # that share no source numbers with 'term'
        index = 1
        term_mask = term.mask

        # skip over indices that clash with term_mask
        index += collision - ((collision - 1) & index) while
                    (collision = term_mask & index) != 0
        while index < @num_hashes
          hash = @term_hashes[index]

          # iterate through the hashes and build composite terms using
          # the four basic operators
          hash.each_value do |other|
            new_mask = term_mask | other.mask
            hash = @term_hashes[new_mask]
            new_hash = new_hashes[new_mask]

            # sort the source terms so that the term with the larger
            # value is left
            # (we don't allow fractions and negative subterms are not
            # necessairy as long as the target is positive)
            if term.value > other.value
              left_term = term
              right_term = other
            else
              left_term = other
              right_term = term
            end
            [:+, :-, :*, :/].each do |op|

              # don't allow fractions
              next if op == :/ &&
                      left_term.value % right_term.value != 0

              # calculate value of composite term
              value = left_term.value.send(op, right_term.value)

              # don't allow zero
              next if value == 0

              # ignore this composite term if this value was already
              # found for a different term using the same source
              # numbers
              next if hash.has_key?(value) || new_hash.has_key?(value)

              new_term = Term.new(value, new_mask, op, left_term,
                                  right_term)

              # if the new term is closer to the target than the
              # best match so far print it out
              if (value - @target).abs < best_difference
                best_difference = (value - @target).abs
                printf "%s = %d (error: %d)\n", new_term, value,
                                    best_difference
                return if best_difference == 0
              end

              # remember the new term for use in the next iteration
              next_new_terms << new_term
              new_hash[value] = new_term
            end
          end
          index += 1
          index += collision - ((collision - 1) & index) while
                      (collision = term_mask & index) != 0
        end
      end

      # merge the hashes with the new terms into the main hashes
      @term_hashes.each_with_index do |hash, index|
        hash.merge!(new_hashes[index])
      end

      # the newly found terms will be used in the next iteration
      @new_terms = next_new_terms
    end
  end
end



if ARGV[0] && ARGV[0].downcase == 'random'
  ARGV[0] = rand(900) + 100
  ARGV[1] = (rand(4) + 1) * 25
  5.times {|i| ARGV[i + 2] = rand(10) + 1}
end

if ARGV.size < 3
  puts "Usage: ruby #$0 <target> <source1> <source2> ..."
  puts "   or: ruby #$0 random"
  exit
end

start_time = Time.now
Solver.new(ARGV[1..-1].map {|v| v.to_i}, ARGV[0].to_i).run
printf "%f seconds\n", Time.now - start_time

