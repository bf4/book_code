#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require 'rubygems'
require 'action_controller'

ActionController::Routing.use_controllers! [ "article", "blog" ]
rs = ActionController::Routing::Routes
app = ActionDispatch::Integration::Session.new(nil)

ActionController::Routing::Routes.draw do |map| 
  
  # Straight 'http://my.app/blog/' displays the index 
  map.connect "blog/", 
              :controller => "blog", 
              :action => "index" 

  # Return articles for a year, year/month, or year/month/day 
  map.connect "blog/:year/:month/:day", 
              :controller => "blog", 
              :action => "show_date", 
              :requirements => { :year => /(19|20)\d\d/,
                                 :month => /[01]?\d/, 
                                 :day => /[0-3]?\d/}, 
              :day => nil, 
              :month => nil 

  # Show an article identified by an id 
  map.connect "blog/show/:id", 
              :controller => "blog", 
              :action => "show", 
              :id => /\d+/ 
              
  # Regular Rails routing for admin stuff 
  map.connect "blog/:controller/:action/:id" 

  # Catchall so we can gracefully handle badly formed requests 
  map.connect "*anything", 
              :controller => "blog", 
              :action => "unknown_request" 
end

rs.recognize_path "/blog"
rs.recognize_path "/blog/show/123"
rs.recognize_path "/blog/2004"
rs.recognize_path "/blog/2004/12"
rs.recognize_path "/blog/2004/12/25"
rs.recognize_path "/blog/article/edit/123"
rs.recognize_path "/blog/article/show_stats"
rs.recognize_path "/blog/wibble"
rs.recognize_path "/junk"

last_request = rs.recognize_path "/blog/2006/07/28"
rs.generate({:day => 25}, last_request)
rs.generate({:year => 2005}, last_request)
rs.generate({:action => "show" , :id => 123}, last_request)
rs.generate({:year => 2006}, last_request)
rs.generate({:year => 2006, :month => nil}, last_request)

app.url_for :controller => 'blog', :action => 'show_date', :year => 2002
app.url_for :controller => 'blog', :action => 'show_date', :overwrite_params => {:year => "2002" }
