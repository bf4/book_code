#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'text/format'

module MailHelper
  # Uses Text::Format to take the text and format it, indented two spaces for
  # each line, and wrapped at 72 columns.
  def block_format(text)
    formatted = text.split(/\n\r\n/).collect { |paragraph| 
      Text::Format.new(
        :columns => 72, :first_indent => 2, :body_indent => 2, :text => paragraph
      ).format
    }.join("\n")
    
    # Make list points stand on their own line
    formatted.gsub!(/[ ]*([*]+) ([^*]*)/) { |s| "  #{$1} #{$2.strip}\n" }
    formatted.gsub!(/[ ]*([#]+) ([^#]*)/) { |s| "  #{$1} #{$2.strip}\n" }

    formatted
  end
end
