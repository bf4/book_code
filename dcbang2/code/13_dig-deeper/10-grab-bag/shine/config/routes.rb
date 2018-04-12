#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
Rails.application.routes.draw do
  devise_for :users
  root to: "dashboard#index"
  # These supercede other /customers routes, so must
  # come before resource :customers
  get "customers/ng",                to: "customers#ng"
  get "customers/ng/*angular_route", to: "customers#ng"
  resources :customers, only: [ :index, :show, :update ]
  #                                            ^^^^^^^
  get "bootstrap_mockups", to: "bootstrap_mockups#index"
  get "credit_card_info/:id", to: "fake_payment_processor#show"
end
