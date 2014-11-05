#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class Article
  PUBLIC = []
  PREMIUM = []
  def self.list_public
    PUBLIC
  end
  def self.list_premium
    PREMIUM
  end
  def initialize(arg)
    @when = Time.now
  end
  def save
    PUBLIC << self
  end
  def find(a)
  end
end

class User
  def active?
    true
  end
  def find(a)
    self.new
  end
end

class ContentController < ApplicationController
  before_filter :verify_premium_user, :except => :public_content

  caches_page   :public_content
  caches_action :premium_content
  def public_content
    @articles = Article.list_public
  end

  def premium_content
    @articles = Article.list_premium
  end

  def create_article
    article = Article.new(params[:article])
    if article.save
      expire_page :action => "public_content"
    else
      # ...
    end
  end
  def update_article
    article = Article.find(params[:id])
    if article.update_attributes(params[:article])
      expire_action :action => "premium_content", :id => article
    else
      # ...
    end
  end
  def delete_article
    Article.destroy(params[:id])
    expire_page   :action => "public_content"
    expire_action :action => "premium_content", :id => params[:id]
  end

  private

  def verify_premium_user
    user = session[:user_id]
    user = User.find(user) if user
    unless user && user.active?
      redirect_to :controller => "login", :action => "signup_new"
    end
  end
end
