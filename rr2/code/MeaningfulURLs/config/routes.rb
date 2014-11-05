#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/service.wsdl', :action => 'wsdl'
  map.connect ':controller/:action/:id'
end
ActionController::Routing::Routes.draw do |map|
  map.connect 'daily/:month/:day/:year', :controller => 'recipes', 
                                         :action => 'list',
                                         :filter => 'daily',
                                         :month => Time.now.month,
                                         :day => Time.now.day,
                                         :year => Time.now.year, 
                                         :requirements => {
                                           :year => /\d+/, 
                                           :day => /\d+/, 
                                           :month => /\d+/
                                          }
  map.popular 'popular/:tag', :controller => 'recipes', :action => 'list', :tag => '', :filter => 'popular'
  map.connect ':user/:tag', :controller => 'recipes', :action => 'list', :tag => '', :filter => 'user' 
  map.connect 'uta/tumba/chennaagide', :controller => 'recipes', 
                                  :action => 'list', 
                                  :filter => 'popular',
                                  :tag => 'south indian'
end
