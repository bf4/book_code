#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
ActionController::Routing::Routes.draw do |map| 
  
  # Straight 'http://my.app/blog/' displays the index 
  map.index "blog/", 
            :controller => "blog", 
            :action => "index" 

  # Return articles for a year, year/month, or year/month/day 
  map.date "blog/:year/:month/:day", 
           :controller => "blog", 
           :action => "show_date", 
           :requirements => { :year => /(19|20)\d\d/,
                              :month => /[01]?\d/, 
                              :day => /[0-3]?\d/}, 
           :day => nil, 
           :month => nil 

  # Show an article identified by an id 
  map.show_article "blog/show/:id", 
                   :controller => "blog", 
                   :action => "show", 
                   :id => /\d+/ 
                
  # Regular Rails routing for admin stuff 
  map.blog_admin "blog/:controller/:action/:id" 

  # Catchall so we can gracefully handle badly formed requests 
  map.catch_all "*anything", 
                :controller => "blog", 
                :action => "unknown_request" 
end
