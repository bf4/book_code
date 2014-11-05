#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
module AnalyticsUtil
  def self.pearson_r(x, y)
    if x.empty?
      0
    else
      n=x.size

      sum_x = x.inject(0) { |r, i| r + i }
      sum_y = y.inject(0) { |r, i| r + i }

      sum_x_sq = x.inject(0) { |r, i| r + i**2 }
      sum_y_sq = y.inject(0) { |r, i| r + i**2 }

      prods = []; x.each_with_index { |this_x, i| prods << this_x*y[i] }
      p_sum = prods.inject(0) { |r, i| r + i }

      # Calculate Pearson score
      num = p_sum-(sum_x*sum_y/n)
      den = ((sum_x_sq-(sum_x**2)/n)*(sum_y_sq-(sum_y**2)/n))**0.5

      den == 0 ? 0 : num/den
    end
  end

  def self.standard_dev(vals)
    if vals.empty?
      0
    else
      avg = (vals.inject(0) {|sum, s| sum + s}) / vals.size
      diffs = vals.map {|s| (s-avg)**2}
      Math.sqrt((diffs.inject(0) {|sum, s| sum + s}) / vals.size)
    end
  end
end