#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class PreparesCartForStripeJob < ApplicationJob

  queue_as :default

  rescue_from(ChargeSetupValidityException) do |exception|
    PaymentMailer.notify_failure(exception).deliver_later
    Rollbar.error(exception)
  end

  rescue_from(PreExistingPaymentException) do |exception|
    Rollbar.error(exception)
  end

  def perform(user:, purchase_amount_cents:, expected_ticket_ids:,
      payment_reference:, params:, discount_code_string:)
    token = StripeToken.new(**card_params(params))
    user.tickets_in_cart.each do |ticket|
      ticket.update(payment_reference: payment_reference)
    end
    purchases_cart_workflow = PrepareForCartPurchaseViaStripe.new(
        user: user, stripe_token: token,
        purchase_amount_cents: purchase_amount_cents,
        expected_ticket_ids: expected_ticket_ids,
        payment_reference: payment_reference,
        discount_code_string: discount_code_string)
    purchases_cart_workflow.run
  end

  def success
    true
  end

  def redirect_on_success_url
    nil
  end

  private def card_params(params)
    params.slice(
        :credit_card_number, :expiration_month,
        :expiration_year, :cvc,
        :stripe_token).symbolize_keys
  end

end
