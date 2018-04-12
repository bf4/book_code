#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
Rails.application.routes.draw do

  # Notes App -- ReactNative
  resources :notes
  get 'reverse_geocode/', to: 'reverse_geocode#reverse_geocode'

  # Todos App -- RubyMotion
  resources :todos

  # World Clock App -- Web
  get 'clock/time_zones'

  # Weather Forecast App -- iOS
  match 'weather/', to: 'weather#index', as: :weather, via: [:get, :post]
  get 'weather/location'
  get 'weather/:zip', to: 'weather#zip', as: :weather_for_zip

  # Currency Conversion App -- Android/Xamarin
  match 'convert/', to: 'convert#index', as: :convert, via: [:get, :post]
  get 'convert/:from_currency/:to_currency', to: 'convert#convert', as: :convert_result, from_currency: /[A-Za-z]{3}/, to_currency: /[A-Za-z]{3}/

  # Stock Quotes App -- Windows
  match 'stock_quotes/:symbols', to: 'stock_quotes#index', as: :stock_quotes, via: [:get]

end
