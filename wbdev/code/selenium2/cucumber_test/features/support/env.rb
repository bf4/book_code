#---
# Excerpted from "Web Development Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
#---
require 'webrat'
require 'webrat/core/matchers'
require 'sauce'

SAUCE = ENV["HUB"].match(/sauce/)

Before do |scenario|
  browser = ENV["BROWSER"] || "firefox"
  browser_version = ENV["VERSION"] || "3."
  os = ENV["OS"] || "Windows 2003"
  host_to_test = ENV["HOST_TO_TEST"] || "http://www.google.com"
  app_port = ENV["APP_PORT"] == 80 ? "" : ":#{ENV["APP_PORT"]}"

  # Because Sauce Labs has their own gem that works better against the Sauce severs we want to use that
  # when we are running against Sauce. Otherwise the good ol' Selenium Client Driver will do
  @selenium = Sauce::Selenium.new(:browser_url => host_to_test + app_port, 
                                  :browser => browser, 
                                  :browser_version => browser_version, 
                                  :os => os,
                                  :job_name => scenario.name)
  @selenium.start_new_browser_session
end

After do |scenario|
  @selenium.stop
end
