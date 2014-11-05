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
require "sinatra/mustache"
require "json"

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/bookmarks.db")
DataMapper.finalize.auto_upgrade!

before %r{/bookmarks/(\d+)} do |id|
  @bookmark = Bookmark.get(id)

  if !@bookmark
    halt 404, "bookmark #{id} not found"
  end
end

with_tagList = {:methods => [:tagList]}

get %r{bookmarks/\d+} do
  if @bookmark
    content_type :json
    @bookmark.to_json with_tagList
  end
end

post %r{bookmarks/\d+} do
  if @bookmark
    input = JSON.parse(request.body.read)
    if @bookmark.update(input.only "url", "title")
      add_tags(@bookmark, input)
      200 # OK
    else
      400 # Bad Request
    end
  end
end

delete %r{bookmarks/\d+} do
  if @bookmark
    if @bookmark.destroy
      200 # OK
    else
      500 # Internal Server Error
    end
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

get "/bookmarks" do
  content_type :json
  Bookmark.all.to_json with_tagList
end

post "/bookmarks" do
  input = JSON.parse(request.body.read)
  bookmark = Bookmark.new(input.only "url", "title")
  if bookmark.save
    add_tags(bookmark, input)

    # Created
    [201, bookmark.to_json(with_tagList)]
  else
    400 # Bad Request
  end
end

get "/" do
  redirect "/example/base"
end

get "/example/:example" do
  @examples = [
    {:example => "base", :label => "Base"},
    {:example => "validation", :label => "Validation"},
    {:example => "tagfilter", :label => "Tag Filter"},
    {:example => "routing", :label => "Routing"}
  ]
  @example = params[:example]

  @examples.each do |example|
    if example[:example] == @example
      example[:active] = true
    end
  end

  @example_template = IO.read("views/#{@example}.html")

  mustache :index
end

helpers do
  def add_tags(bookmark, input)
    tagList = (input["tagList"] || []).map(&:strip)

    # Remove taggings that previously existed but were not sent
    # Remove existing taggings from tagList to be added
    existing_labels = []
    bookmark.taggings.each do |tagging|
      if tagList.include? tagging.tag.label
        existing_labels.push tagging.tag.label
      else
        tagging.destroy
      end
    end

    # Add tags that were sent, if they are new
    (tagList - existing_labels).each do |label|
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
  def only(*whitelist)
    whitelist.inject({}) {|result, key| result.merge key => self[key]}
  end
end
