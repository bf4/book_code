#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require 'builder'
require 'active_record'
 
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3')
 
class Product < ActiveRecord::Base
end
 
class StoreApp
  def call(env)
    x = Builder::XmlMarkup.new :indent=>2
 
    x.declare! :DOCTYPE, :html
    x.html do
      x.head do
        x.title 'Pragmatic Bookshelf'
      end
      x.body do
        x.h1 'Pragmatic Bookshelf'
 
        Product.all.each do |product|
          x.h2 product.title
          x << "      #{product.description}\n"
          x.p product.price
        end
      end
    end
 
    response = Rack::Response.new(x.target!)
    response['Content-Type'] = 'text/html'
    response.finish
  end
end
