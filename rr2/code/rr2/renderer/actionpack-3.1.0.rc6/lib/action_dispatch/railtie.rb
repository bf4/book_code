#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require "action_dispatch"
require "rails"

module ActionDispatch
  class Railtie < Rails::Railtie
    config.action_dispatch = ActiveSupport::OrderedOptions.new
    config.action_dispatch.x_sendfile_header = nil
    config.action_dispatch.ip_spoofing_check = true
    config.action_dispatch.show_exceptions = true
    config.action_dispatch.best_standards_support = true
    config.action_dispatch.tld_length = 1
    config.action_dispatch.ignore_accept_header = false
    config.action_dispatch.rack_cache = {:metastore => "rails:/", :entitystore => "rails:/", :verbose => true}

    initializer "action_dispatch.configure" do |app|
      ActionDispatch::Http::URL.tld_length = app.config.action_dispatch.tld_length
      ActionDispatch::Request.ignore_accept_header = app.config.action_dispatch.ignore_accept_header
    end
  end
end
