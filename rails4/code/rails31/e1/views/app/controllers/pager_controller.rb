#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
Rails::Initializer.run do |config|
  config.gem 'will_paginate', :version => '~> 2.3.11',
    :source => 'http://gemcutter.org'
end
    
class PagerController < ApplicationController

  def populate
    User.delete_all
    ["Chris Pine",
     "Chad Fowler",
     "Dave Thomas",
     "Andy Hunt",
     "Adam Keys",
     "Maik Schmidt",
     "Mike Mason",
     "Greg Wilson",
     "Jeffrey Fredrick",
     "James Gray",
     "Daniel Berger",
     "Eric Hodel",
     "Brian Marick",
     "Mike Gunderloy",
     "Ryan Davis",
     "Scott Davis",
     "David Heinemeier Hansson",
     "Scott Barron",
     "Marcel Molina",
     "Brian McCallister",
     "Mike Clark",
     "Esther Derby",
     "Johanna Rothman",
     "Juliet Thomas",
     "Thomas Fuchs"].each {|name| User.create(:name => name)}

    763.times do |i|
      User.create(:name => "ZZUser #{"%03d" % i}")
    end
  end

  def user_list
    @users = User.paginate :page => params[:page], :order => 'name'
  end

end
