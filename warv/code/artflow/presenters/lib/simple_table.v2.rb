#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class SimpleTable

  attr_reader :columns

  delegate :each, to: :@records
  
  def initialize(template, records, columns = {})
    @template = template
    @records  = records
    @columns  = columns
  end

  def values(record)
    @columns.each_with_object({}) do |(title, attribute), memo|
      memo[title] = record.send(attribute)
    end
  end

  def to_s
    @template.render partial: 'presenters/simple_table', object: self
  end

end
