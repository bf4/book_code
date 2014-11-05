#---
# Excerpted from "Seven Web Frameworks in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
#---
require "sinatra"
require "data_mapper"
require_relative "bookmark"
require "dm-serializer"

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/bookmarks.db")
DataMapper.finalize.auto_upgrade!

before "/bookmarks/:id" do |id|
  @bookmark = Bookmark.get(id)
  if !@bookmark
    halt 404, "bookmark #{id} not found"
  end
end

get "/bookmarks/:id" do
  content_type :json
  @bookmark.to_json
end

put "/bookmarks/:id" do
  input = params.slice "url", "title"
  
  if @bookmark.update input
    204 # No Content
  else
    400 # Bad Request
  end
end

delete "/bookmarks/:id" do
  if @bookmark.destroy
    200 # OK
  else
    500 # Internal Server Error
  end
end

def get_all_bookmarks
  Bookmark.all(:order => :title)
end

get "/bookmarks" do
  content_type :json
  get_all_bookmarks.to_json
end

post "/bookmarks" do
  input = params.slice "url", "title"
  bookmark = Bookmark.new input
  if bookmark.save
    # Created
    [201, "/bookmarks/#{bookmark['id']}"]
  else
    400 # Bad Request
  end
end

class Hash
  def slice(*whitelist)
    whitelist.inject({}) {|result, key| result.merge(key => self[key])}
  end
end
