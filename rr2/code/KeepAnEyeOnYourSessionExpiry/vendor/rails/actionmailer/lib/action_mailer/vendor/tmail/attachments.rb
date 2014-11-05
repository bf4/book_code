#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'stringio'

module TMail
  class Attachment < StringIO
    attr_accessor :original_filename, :content_type
  end

  class Mail
    def has_attachments?
      multipart? && parts.any? { |part| attachment?(part) }
    end

    def attachment?(part)
      (part['content-disposition'] && part['content-disposition'].disposition == "attachment") ||
      part.header['content-type'].main_type != "text"
    end

    def attachments
      if multipart?
        parts.collect { |part| 
          if attachment?(part)
            content   = part.body # unquoted automatically by TMail#body
            file_name = (part['content-location'] &&
                          part['content-location'].body) ||
                        part.sub_header("content-type", "name") ||
                        part.sub_header("content-disposition", "filename")
            
            next if file_name.blank? || content.blank?
            
            attachment = Attachment.new(content)
            attachment.original_filename = file_name.strip
            attachment.content_type = part.content_type
            attachment
          end
        }.compact
      end      
    end
  end
end
