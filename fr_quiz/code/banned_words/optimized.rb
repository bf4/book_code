#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
require "test_harness"

class YourAlgorithm < RQ9Algorithm
  # Returns an array containing all banned words from @words
  def run()
    if @words.empty?
      []
    else
      find_banned(@words)
    end
  end

  # Returns an array containing all banned words from words
  # words.size is > 0
  def find_banned(words)
    if words.size == 1
      @filter.clean?(words[0]) ? [] : words
    elsif @filter.clean?(words.join(' '))
      []
    else
      split_index = words.size / 2
      if @filter.clean?(words[0...split_index].join(' '))
        # There is at least one banned word in 0..-1, but not in
        # 0...split_index, so there must be one in split_index..-1
        find_banned_there_is_one(words[split_index..-1])
      else
        # From the test above we know there is a banned word in 0...split_index
        find_banned_there_is_one( words[0...split_index]) +
                                  find_banned(words[split_index..-1] )
      end
    end
  end

  # Returns an array containing all banned words from words
  # words.size is > 0
  # Our caller has determined there is at least one banned word in words
  def find_banned_there_is_one(words)
    if words.size == 1
      # Since we know there is at least one banned word and since there is
      # only one word in the array, we know this word is banned without
      # having to call clean?
      words
    else
      split_index = words.size / 2
      if @filter.clean?(words[0...split_index].join(' '))
        # There is at least one banned word in 0..-1, but not in 0...split_index,
        # so there must be one in split_index..-1
        find_banned_there_is_one(words[split_index..-1])
      else
        # From the previous test we know there is a banned word 
        # in 0...split_index
        find_banned_there_is_one( words[0...split_index]) +
                                  find_banned(words[split_index..-1] )
      end
    end
  end
end
