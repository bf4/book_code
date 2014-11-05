#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Globalize
  class Country < ActiveRecord::Base # :nodoc:
    set_table_name "globalize_countries"

    def self.reloadable?; false end

    def self.pick(rfc)

      # assume it's a country code string
      if rfc.kind_of?(String)
        find_by_code(rfc)  
      elsif rfc.kind_of?(RFC_3066)
        rfc.country ? find_by_code(rfc.country) : nil
      else
        raise ArgumentError, "argument must be String or RFC_3066 object"
      end
    end

    def number_grouping_scheme
      attr = read_attribute(:number_grouping_scheme)
      attr ? attr.intern : nil
    end
  end
end
