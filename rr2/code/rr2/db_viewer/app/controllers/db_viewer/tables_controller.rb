#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module DbViewer
  class TablesController < ApplicationController
    def index
      @tables = ActiveRecord::Base.connection.tables.sort
    end

    def show
      @table = ActiveRecord::Base.connection.columns params[:id]
    end
  end
end
