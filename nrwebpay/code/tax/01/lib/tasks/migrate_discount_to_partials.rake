namespace :snow_globe do
  task migrate_discounts: :environment do
    Payment.transaction do
      Payment.all.each do |payment|
        partials = {}
        if payment.discount_cents.positive?
          partial[:discount_cents] = -discount_cents
        end
        partial[:tickets].each = payment.tickets.map(&:price_cents)
        payment.update(partials: partials)
      end
    end
  end
end
