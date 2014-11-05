#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Enumerable #:nodoc:
  def first_match
    match = nil
    each do |items|
      break if match = yield(items)
    end
    match
  end

  # Collect an enumerable into sets, grouped by the result of a block. Useful,
  # for example, for grouping records by date.
  #
  # e.g. 
  #
  #   latest_transcripts.group_by(&:day).each do |day, transcripts| 
  #     p "#{day} -> #{transcripts.map(&:class) * ', '}"
  #   end
  #   "2006-03-01 -> Transcript"
  #   "2006-02-28 -> Transcript"
  #   "2006-02-27 -> Transcript, Transcript"
  #   "2006-02-26 -> Transcript, Transcript"
  #   "2006-02-25 -> Transcript"
  #   "2006-02-24 -> Transcript, Transcript"
  #   "2006-02-23 -> Transcript"
  def group_by
    inject({}) do |groups, element|
      (groups[yield(element)] ||= []) << element
      groups
    end
  end 
end
