#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
=begin
  Copyright (C) 2005 Jeff Rose

  This library is free software; you can redistribute it and/or modify it
  under the same terms as the ruby language itself, see the file COPYING for
  details.
=end

module Icalendar

  # A property can have attributes associated with it. These "property
  # parameters" contain meta-information about the property or the
  # property value. Property parameters are provided to specify such
  # information as the location of an alternate text representation for a
  # property value, the language of a text property value, the data type
  # of the property value and other attributes.
  class Parameter < Icalendar::Content

    def to_s
      s = ""
      
      s << "#{@name}="
      if is_escapable?
        s << escape(print_value())
      else
        s << print_value
      end

      s
    end

  end
end
