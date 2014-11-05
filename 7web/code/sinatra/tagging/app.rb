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
require_relative "tagging"
require_relative "tag"
require "dm-serializer"

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/bookmarks.db")
DataMapper.finalize.auto_migrate!

before %r{/bookmarks/(\d+)} do |id|
  # ...
  @bookmark = Bookmark.get(id)

  if !@bookmark
    halt 404, "bookmark #{id} not found"
  end
end

with_tagList = {:methods => [:tagList]}

get %r{/bookmarks/\d+} do
  content_type :json

  @bookmark.to_json with_tagList
end

put %r{/bookmarks/\d+} do
  # ...
  input = params.slice "url", "title"
  if @bookmark.update input
    add_tags(@bookmark)
    204 # No Content
  else
    400 # Bad Request
  end
end

delete %r{/bookmarks/\d+} do
  # ...
  if @bookmark.destroy
    200 # OK
  else
    500 # Internal Server Error
  end
end

get "/bookmarks/*" do
  tags = params[:splat].first.split "/"
  bookmarks = Bookmark.all
  tags.each do |tag|
    bookmarks = bookmarks.all({:taggings => {:tag => {:label => tag}}})
  end
  bookmarks.to_json with_tagList
end

def get_all_bookmarks
  Bookmark.all(:order => :title)
end

get "/bookmarks" do
  content_type :json
  get_all_bookmarks.to_json with_tagList
end

post "/bookmarks" do
  input = params.slice "url", "title"
  bookmark = Bookmark.new input
  if bookmark.save
    add_tags(bookmark)

    # Created
    [201, "/bookmarks/#{bookmark['id']}"]
  else
    400 # Bad Request
  end
end

helpers do
  def add_tags(bookmark)
    labels = (params["tagsAsString"] || "").split(",").map(&:strip)
    # more code to come

    existing_labels = []
    bookmark.taggings.each do |tagging|
      if labels.include? tagging.tag.label
        existing_labels.push tagging.tag.label
      else
        tagging.destroy
      end
    end

    (labels - existing_labels).each do |label|
      tag = {:label => label}
      existing = Tag.first tag
      if !existing
        existing = Tag.create tag
      end
      Tagging.create :tag => existing, :bookmark => bookmark
    end
  end
end

class Hash
  def slice(*whitelist)
    whitelist.inject({}) {|result, key| result.merge(key => self[key])}
  end
end
