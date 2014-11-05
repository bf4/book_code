#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
module DesignersHelper

  def designer_status_for(designer = @designer)
    presenter = DesignerStatus.new(designer)
    if block_given?
      yield presenter
    else
      presenter
    end
  end

end

module DesignersHelper

  def designer_status_for(designer = @designer, options = {})
    presenter = DesignerStatus.new(designer, options)
    if block_given?
      yield presenter
    else
      presenter
    end
  end

  def designer_status_for(designer = @designer, options = {})
    presenter = DesignerStatus.new(designer, view, options)
    if block_given?
      yield presenter
    else
      presenter
    end
  end
  
end
