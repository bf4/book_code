#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class SimpleTable

  def initialize(records, columns, template)
    @records = records
    @columns = columns
    @template = template
  end

end

class SimpleTable

  attr_reader :columns

  delegate :each, to: :@records
  
  def initialize(records, columns, options = {})
    @records = records
    @columns = columns
    @options = options
  end

  def values(record)
    @columns.inject({}) do |memo, (title, attribute)|
      memo[title] = record.send(attribute)
      memo
    end
  end

end

class SimpleTable
  def values(record)
    @columns.values.inject({}) do |memo, (title, extractor)|
      memo[title] = extract_value(record, extractor)
      memo
    end    
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
