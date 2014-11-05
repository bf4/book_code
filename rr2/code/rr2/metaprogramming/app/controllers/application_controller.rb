#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ApplicationController < ActionController::Base
  def self.search_action_for(table, options = {})
    table = table.to_s
    model_class = table.classify.constantize     
    define_method(:search) do
      @title = options[:title] || "Your #{table.humanize}"
      search_column = options[:search_column] || 'name'
      @display_as = options[:display_as] || :name
      @display_path = options[:display_path] || "#{table.singularize}_path"         
      @results = model_class.where("#{search_column} like ?", "%#{params[:term]}%") 
      render 'shared/search_results'      
    end
    #FIXME: do routing configuration here
    
  end
end
