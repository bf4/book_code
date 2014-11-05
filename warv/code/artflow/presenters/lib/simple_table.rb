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
    @columns.values.each_with_object({}) do |(title, extractor), memo|
      memo[title] = extract_value(record, extractor)
    end
  end

  def to_s
    @template.render partial: 'presenters/simple_table', object: self
  end

  private

  def extract_value(record, extractor)
    if extractor.respond_to?(:call)
      extractor.call(record)
    else
      record.send(extractor)
    end
  end

end
