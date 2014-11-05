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
    model_class = Object.const_get(table.to_s.classify) 
    define_method(:search) do
      search_code = lambda do 
        @title = options[:title] || "Your #{table.humanize}"
        search_column = options[:search_column] || 'name'
        @display_as = options[:display_as] || :name
        @display_action = options[:display_action] || "view"         
        @results = model_class.find(:all, :conditions => 
                         ["#{search_column} like ?", "%#{params[:term]}%"])
        render :template => 'shared/search_results'      
      end
      (options[:scoped] == false) ?  
           search_code.call : scope(model_class, &search_code) 
    end
  end
  def scope(model_class, &block)
    model_class.with_scope(
       :find => { :conditions => ['account_id = ?', current_user.account_id] }, 
        &block)
  end
end
