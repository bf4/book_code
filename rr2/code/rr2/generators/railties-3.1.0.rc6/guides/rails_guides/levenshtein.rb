#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module RailsGuides
  module Levenshtein
    # Based on the pseudocode in http://en.wikipedia.org/wiki/Levenshtein_distance.
    def self.distance(s1, s2)
      s = s1.unpack('U*')
      t = s2.unpack('U*')
      m = s.length
      n = t.length

      # matrix initialization
      d = []
      0.upto(m) { |i| d << [i] }
      0.upto(n) { |j| d[0][j] = j }

      # distance computation
      1.upto(m) do |i|
        1.upto(n) do |j|
          cost = s[i] == t[j] ? 0 : 1
          d[i][j] = [
            d[i-1][j] + 1,      # deletion
            d[i][j-1] + 1,      # insertion
            d[i-1][j-1] + cost, # substitution
          ].min
        end
      end

      # all done
      return d[m][n]
    end
  end
end
