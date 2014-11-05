#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
ActionController::Routing::Routes.draw do |map|
  map.connect 'store/checkout',
       :conditions => { :method => :get },
       :controller => "store",
       :action     => "display_checkout_form"

  map.connect 'store/checkout',
       :conditions => { :method => :post },
       :controller => "store",
       :action     => "save_checkout_form"
end
