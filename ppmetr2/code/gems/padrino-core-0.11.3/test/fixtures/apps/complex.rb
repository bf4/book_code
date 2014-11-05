#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
PADRINO_ROOT = File.dirname(__FILE__) unless defined? PADRINO_ROOT

module LibDemo
  def self.give_me_a_random
    @rand ||= rand(100)
  end
end

class Complex1Demo < Padrino::Application
  set :reload, true
  get("/old"){ "Old Sinatra Way" }
end

class Complex2Demo < Padrino::Application
  set :reload, true
  get("/old"){ "Old Sinatra Way" }

  controllers :var do
    get(:destroy){ params.inspect }
  end

  get("/"){ "The magick number is: 12!" } # Change only the number!!!
end

Complex1Demo.controllers do
  get("/"){ "Given random #{LibDemo.give_me_a_random}" }
end

Complex2Demo.controllers do
end

Padrino.load!
