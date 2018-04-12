namespace :theater do

  task create_plans: :environment do
    plans = [
        {remote_id: "orchestra_monthly", plan_name: "Orchestra Monthly",
         price_cents: 10_000, interval: "monthly", tickets_allowed: 1,
         ticket_category: "Orchestra"},
        {remote_id: "balcony_monthly", plan_name: "Balcony Monthly",
         price_cents: 60_000, interval: "monthly", tickets_allowed: 1,
         ticket_category: "Balcony"},
        {remote_id: "vip_monthly", plan_name: "VIP Monthly",
         price_cents: 30_000, interval: "monthly", tickets_allowed: 1,
         ticket_category: "VIP"}
    ]
    Plan.transaction do
      plans.each { |plan_data| CreatesPlan.new(**plan_data).run }
    end
  end

end
