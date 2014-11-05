#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class DateTime
  # Returns a JSON string representing the datetime. If ActiveSupport.use_standard_json_time_format is set to true, the
  # ISO 8601 format is used.
  #
  # ==== Examples
  #
  #   # With ActiveSupport.use_standard_json_time_format = true
  #   DateTime.civil(2005,2,1,15,15,10).to_json
  #   # => "2005-02-01T15:15:10+00:00"
  #
  #   # With ActiveSupport.use_standard_json_time_format = false
  #   DateTime.civil(2005,2,1,15,15,10).to_json
  #   # => "2005/02/01 15:15:10 +0000"
  def to_json(options = nil)
    if ActiveSupport.use_standard_json_time_format
      xmlschema.inspect
    else
      strftime('"%Y/%m/%d %H:%M:%S %z"')
    end
  end
end
