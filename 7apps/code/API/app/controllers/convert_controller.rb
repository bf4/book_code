#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class ConvertController < ActionController::Base

  def index
    if request.post? and (params[:from_currency] and params[:to_currency])
      redirect_to convert_result_url from_currency: params[:from_currency], to_currency: params[:to_currency], amount: params[:amount]
    else
      render "convert/index"
    end
  end

  def convert
    # Uncomment to make this call run long
    # sleep 10.seconds
    @from_currency = params[:from_currency]
    @to_currency = params[:to_currency]
    @conversion = CurrencyConversion.for(params[:from_currency], params[:to_currency])
    @amount = params[:amount]
    @conversion_amount = @conversion.for_amount(@amount)
    render "convert/convert"
  end

end
