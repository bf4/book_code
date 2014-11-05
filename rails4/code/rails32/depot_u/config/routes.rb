#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require './app/store'
Depot::Application.routes.draw do
  match 'catalog' => StoreApp.new
  get 'admin' => 'admin#index'
  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  scope '(:locale)' do
    resources :users
    resources :orders do
      resources :line_items
    end

    resources :line_items
    resources :carts
    resources :products do
      get :who_bought, on: :member
    end
    root to: 'store#index', as: 'store'
  end
end
