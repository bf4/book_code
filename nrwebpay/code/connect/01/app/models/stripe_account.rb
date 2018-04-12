#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class StripeAccount

  attr_accessor :affiliate, :account, :tos_checked, :request_ip

  def initialize(affiliate, tos_checked:, request_ip:)
    @affiliate = affiliate
    @tos_checked = tos_checked
    @request_ip = request_ip
  end

  def account
    @account ||= begin
      if affiliate.stripe_id.blank?
        create_account
      else
        retrieve_account
      end
    end
  end

  private def create_account
    account_params = {country: affiliate.country, managed: true}
    if tos_checked
      account_params[:tos_acceptance] = {date: Time.now.to_i, ip: request_ip}
    end
    Stripe::Account.create(account_params)
  end

  private def retrieve_account
    Stripe::Account.retrieve(affiliate.stripe_id)
  end

end
