#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require "./config/environment.rb"

ActionController::Routing.use_controllers! ["store", "admin", "coupon"]
load "config/routes.rb"
rs = ActionController::Routing::Routes
app = ActionDispatch::Integration::Session.new(nil)

puts rs.routes
rs.recognize_path "/store"
rs.recognize_path "/store/add_to_cart/1"
rs.recognize_path "/store/add_to_cart/1.xml"
rs.generate :controller => :store
rs.generate :controller => :store, :id => 123
rs.recognize_path "/coupon/show/1"
load "config/routes.rb"
rs.recognize_path "/coupon/show/1"
app.url_for :controller => :store, :action => :display, :id => 123
