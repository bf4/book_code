#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: "visitors#index"

  devise_for :users, controllers: {
      sessions: "users/sessions"}

  devise_scope :user do
    post "users/sessions/verify" => "Users::SessionsController"
  end

  resources :events
  resource :shopping_cart
  resource :subscription_cart
  resources :payments
  resources :users
  resources :plans
  resources :subscriptions
  resources :refund

  get "paypal/approved", to: "pay_pal_payments#approved"

  post "stripe/webhook", to: "stripe_webhook#action"
end
