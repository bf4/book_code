#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
Rails.application.routes.draw do
  devise_for :users
  root to: "projects#index"

  resources :tasks do
    member do
      patch :up
      patch :down
    end
  end

  resources :projects
end
