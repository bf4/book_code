#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class CreateGenresMovies < ActiveRecord::Migration
  def self.up
    create_table :genres_movies, :id => false do |t|
      t.integer :genre_id
      t.integer :movie_id
      t.timestamps
    end
  end

  def self.down
    drop_table :genres_movies
  end
end
