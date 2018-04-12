#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class PurchaseAudit

  include Reportable

  attr_accessor :payment, :user

  def self.find_collection
    Payment.includes(:user).succeeded.find_each.lazy.map do |payment|
      PurchaseAudit.new(payment)
    end
  end

  def initialize(payment)
    @payment = payment
    @user = payment.user
  end

  columns do
    column(:reference) { |report| report.payment.reference }
    column(:user_email) { |report| report.user.email }
    column(:user_stripe_id) { |report| report.user.stripe_id }
    column(:price) { |report| report.payment.price.to_f }
    column(:total_value) { |report| report.payment.full_value.to_f }
  end

end
