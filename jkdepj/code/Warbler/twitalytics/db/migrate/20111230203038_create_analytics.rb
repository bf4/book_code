#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
class CreateAnalytics < ActiveRecord::Migration
  def change
    create_table :analytics do |t|
      t.decimal :positivity_followers_r
      t.decimal :positivity_stdv

      t.timestamps
    end
  end
end
