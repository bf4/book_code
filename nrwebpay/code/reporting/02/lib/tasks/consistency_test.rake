namespace :snow_globe do

  task check_consistency: :environment do
    inconsistent = Payment.all.reject do |payment|
      TicketPaymentConsistency.new(payment).consistent?
    end
    if inconsistent.empty?
      ConistencyMailer.all_is_well.deliver
    else
      ConistencyMailer.inconsistencies_detected(inconsistent).deliver
    end
  end

end

class TicketPaymentConsistency < SimpleDelegator

  attr_accessor :errors

  def initialize(payment)
    super
    @errors = []
  end

  def consistent?
    success_consistent
    refund_consistent
    amount_consistent
    errors.empty?
  end

  def success_consistent
    return unless success?
    inconsistent_tickets = tickets.select { |ticket| !ticket.purchased? }
    inconsistent_tickets.each do |ticket|
      @errors << "Successful purchase #{id}, ticket #{ticket.id} not purchased"
    end
  end

  def refund_consistent
    return unless refund?
    inconsistent_tickets = tickets.select { |ticket| !ticket.refunded? }
    inconsistent_tickets.each do |ticket|
      @errors << "Refunded purchase #{id}, ticket #{ticket.id} not refunded"
    end
  end

  def amount_consistent
    expected = payment_line_items.map(&:price) - discount
    return if expected == price
    @errors >>
        "Purchase #{id}, expected price #{expected} actual price #{price}"
  end

end
