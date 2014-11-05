#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Range
  RANGE_FORMATS = {
    :db => Proc.new { |start, stop| "BETWEEN '#{start.to_s(:db)}' AND '#{stop.to_s(:db)}'" }
  }

  # Gives a human readable format of the range.
  #
  #   (1..100).to_formatted_s # => "1..100"
  def to_formatted_s(format = :default)
    if formatter = RANGE_FORMATS[format]
      formatter.call(first, last)
    else
      to_default_s
    end
  end

  alias_method :to_default_s, :to_s
  alias_method :to_s, :to_formatted_s
end
