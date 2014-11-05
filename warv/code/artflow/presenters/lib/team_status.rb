#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class TeamStatus
  
  def initialize(view, designers)
    @view = view
    @designers = designers
    @options = options
  end
end


class TeamStatus

  ORDERS = %w(asc desc)

  def order
    @order ||= safe_order
  end

  private
  
  def safe_order
    provided = params[:order] || session[:order]
    if ORDERS.include?(params[:order])
      params[:order]
    else
      ORDERS.first
    end
  end
  
end

class TeamStatus

  def active_column
    [
     params[:column],
     session[:column],
     @options[:default_column]
    ].compact.first
  end

end

class TeamStatus

  delegate :params, :session, to: :@view
  
end
