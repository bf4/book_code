#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
class CustomersController < ApplicationController

  PAGE_SIZE = 10

  def index

    # method as it was before

    @page = (params[:page] || 0).to_i

    if params[:keywords].present?
      @keywords = params[:keywords]
      customer_search_term = CustomerSearchTerm.new(@keywords)
      @customers = Customer.where(
        customer_search_term.where_clause,
        customer_search_term.where_args).
        order(customer_search_term.order).
        offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
    else
      @customers = []
    end
    respond_to do |format|
      format.html {}
      format.json {
        render json: { customers: @customers }
      }
    end
  end
end

