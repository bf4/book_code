#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
# A filter class for managing a given _banned_words_ list.
class LanguageFilter

  # Create a new LanguageFilter object that will
  # disallow _banned_words_.
  #
  # Accepts a list of words, arrays of words,
  # or a combination of the two.

  def initialize( *banned_words )
    @banned_words = banned_words.flatten.sort
    @clean_calls = 0
  end
  
  # A count of the calls to <i>clean?</i>.
  attr_reader :clean_calls
  
  # Test if provided _text_ is allowable by this filter.
  #
  # Returns *false* if _text_ contains _banned_words_,
  # *true* if it does not.

  def clean?( text )
    @clean_calls += 1
    @banned_words.each do |word|
      return false if text =~ /\b#{word}\b/
    end
    true
  end
  
  # Verify a _suspect_words_ list against the actual
  # _banned_words_ list.
  #
  # Returns *false* if the two lists are not identical or
  # *true* if the lists do match.
  #
  # Accepts a list of words, arrays of words,
  # or a combination of the two.

  def verify( *suspect_words )
    suspect_words.flatten.sort == @banned_words
  end
end

filter = LanguageFilter.new "six"

filter.clean?("I'll be home at six.")             # => false
filter.clean?("Do not taunt the happy fun ball!") # => true

filter.verify("ball") # => false
filter.verify("six")  # => true

filter.clean_calls # => 2
