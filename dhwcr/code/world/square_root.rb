#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'sinatra'

get '/' do
  <<HERE
<!DOCTYPE html>
<html>
  <head>
    <title>Square root</title>
  </head>
  
  <body>
    Enter a number to take the square root:
    <form action="/square_root">
      <input name="number" type="text">
      <input name="submit" type="submit">
    </form>
  </body>
</html>
HERE
end

get '/square_root' do
  number = params[:number].to_f
  result = Math.sqrt(number)
  <<HERE
<!DOCTYPE html>
<html>
  <head>
    <title>Result</title>
  </head>
  
  <body>
    The square root of <span id="number">#{number}</span>
    is <span id="result">#{result}</span>.
  </body>
</html>
HERE
end

get '/api/square_root/:n' do |n|
  Math.sqrt(n.to_f).to_s
end
