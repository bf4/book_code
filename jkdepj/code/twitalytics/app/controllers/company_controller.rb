#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
class CompanyController < ApplicationController
  include TwitterUtil

  def index
    with_twitter_account do |username|
      @username = username
      @statuses = (Twitter.user_timeline(username, :count => 20)).map do |status|
        {:created_at => status.created_at, :status_text => status.text}
      end
    end
  end

  def update
    child = fork do
      post_update(params[:status_text])
    end
    Process.detach(child)
    
    flash[:notice] = "Status updated!"
    redirect_to company_path
  end

  private

  def post_update(text)
    # We won't actually update because that requires an OAuth token.
    # Twitter.update(text)
    sleep 10
    puts "update posted successfully"
  end
end
