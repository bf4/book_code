#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
class Note
  @@app = nil   #(1)
  @@titles = {} #(2)
    
  def self.open
    @@app.new
  end
end


class Note
  def exit!
    close
    
    @prompted = dialog(@@titles[:save]) do |d| #(3)
      d.click '_No'
    end
  end

  def has_prompted?
    @prompted
  end
end
