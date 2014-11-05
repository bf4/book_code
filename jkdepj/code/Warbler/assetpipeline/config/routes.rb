#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
Twitalytics::Application.routes.draw do
  get "customers/index", :as => :customers

  get "company/index", :as => :company

  post "company/update", :as => :company_status

  get "dashboard/index"

  post "customers/retweet/:id", :controller => :customers, :action => :retweet, :as => :retweet

  root :to => "dashboard#index"
end
