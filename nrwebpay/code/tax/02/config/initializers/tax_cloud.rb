#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
TaxCloud.configure do |config|
  config.api_login_id = Rails.application.secrets.tax_cloud_login
  config.api_key = Rails.application.secrets.tax_cloud_key
  # config.usps_username = 'your_usps_username' # optional
end
