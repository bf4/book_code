#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
module StripeHandler

  class InvoicePaymentSucceeded

    attr_accessor :event, :success, :payment

    def intialize(event)
      @event = event
      @success = false
    end

    def run
      Subscription.transaction do
        return unless event
        subscription.active!
        subscription.update_end_date
        @payment = Payment.create!(
            user_id: user.id, price_cents: invoice.amount,
            status: "succeeded", reference: Payment.generate_reference,
            payment_method: "stripe", response_id: invoice.charge,
            full_response: charge.to_json)
        payment.payment_line_items.create!(
            buyable: subscription, price_cents: invoice.amount)
        @success = true
      end
    end

    def invoice
      @event.data.object
    end

    def subscription
      @subscription ||= Subscription.find_by(remote_id: invoice.subscription)
    end

    def user
      @user ||= User.find_by(stripe_id: invoice.customer)
    end

    def charge
      @charge ||= Stripe::Charge.retrieve(invoice.charge)
    end

  end

end
