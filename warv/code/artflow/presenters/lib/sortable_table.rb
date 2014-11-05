#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class SortableTable
  
  def initialize(view, records, options = {})
    @view = view
    @records = records
    @options = options
  end
      
end

class SortableTable

  ORDERS = %w(asc desc)

  def order
    @order ||= safe_order
  end
  
  def safe_order
    provided = params[:order] || session[:order] 
    if ORDERS.include?(provided)
      provided
    else
      ORDERS.first
    end
  end
  
end

class SortableTable

  def active_column
    [
     params[:column],
     session[:column],
     @options[:default_column]
    ].compact.first
  end

end

class SortableTable

  delegate :params, :session, to: :@view
  
  # The rest of our presenter...
  
end
