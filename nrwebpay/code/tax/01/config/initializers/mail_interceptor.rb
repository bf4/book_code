#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
unless Rails.env.test? || Rails.env.production?

  options = {forward_emails_to: "noel@noelrappin.com",
             deliver_emails_to: ["@snowglobetheater.com"]}

  interceptor = MailInterceptor::Interceptor.new(options)
  ActionMailer::Base.register_interceptor(interceptor)

  EmailPrefixer.configure do |config|
    config.application_name = "Snow Globe"
  end
end
