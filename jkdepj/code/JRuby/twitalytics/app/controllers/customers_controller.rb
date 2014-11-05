#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
class CustomersController < ApplicationController
  include TwitterUtil

  def index
    @statuses =  Status.find_or_create_from(
        fetch_recent_tweets(20)
    )
  end

  def retweet
    Status.find(params[:id]).retweet
    redirect_to customers_path
  end
end
