#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
PADRINO_ROOT = File.dirname(__FILE__) unless defined? PADRINO_ROOT
# Remove this comment if you want do some like this: ruby PADRINO_ENV=test app.rb
#
# require 'rubygems'
# require 'padrino-core'
#

class SimpleDemo < Padrino::Application
  set :reload, true
  before { true }
  after  { true }
  error(404) { "404" }
end

SimpleDemo.controllers do
  get "/" do
    'The magick number is: 2767356926488785838763860464013972991031534522105386787489885890443740254365!' # Change only the number!!!
  end

  get "/rand" do
    rand(2 ** 256).to_s
  end
end

## If you want use this as a standalone app uncomment:
#
# Padrino.mount("SimpleDemo").to("/")
# Padrino.run! unless Padrino.loaded? # If you enable reloader prevent to re-run the app
#
# Then run it from your console: ruby -I"lib" test/fixtures/apps/simple.rb
#

Padrino.load!
