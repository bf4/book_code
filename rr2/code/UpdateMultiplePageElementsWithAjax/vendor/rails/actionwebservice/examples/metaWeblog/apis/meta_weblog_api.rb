#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
# 
# here lie structures, cousins of those on http://www.xmlrpc.com/metaWeblog
# but they don't necessarily the real world reflect
# so if you do, find that your client complains:
# please tell, of problems you suffered through
#

module Blog
  class Post < ActionWebService::Struct
    member :title,       :string
    member :link,        :string
    member :description, :string
    member :author,      :string
    member :category,    :string
    member :comments,    :string
    member :guid,        :string
    member :pubDate,     :string
  end

  class Category < ActionWebService::Struct
    member :description, :string
    member :htmlUrl,     :string
    member :rssUrl,      :string
  end
end

#
# metaWeblog
#
class MetaWeblogAPI < ActionWebService::API::Base
  inflect_names false

  api_method :newPost, :returns => [:string], :expects => [
    {:blogid=>:string},
    {:username=>:string},
    {:password=>:string},
    {:struct=>Blog::Post},
    {:publish=>:bool}
  ]

  api_method :editPost, :returns => [:bool], :expects => [
    {:postid=>:string},
    {:username=>:string},
    {:password=>:string},
    {:struct=>Blog::Post},
    {:publish=>:bool},
  ]

  api_method :getPost, :returns => [Blog::Post], :expects => [
    {:postid=>:string},
    {:username=>:string},
    {:password=>:string},
  ]

  api_method :getCategories, :returns => [[Blog::Category]], :expects => [
    {:blogid=>:string},
    {:username=>:string},
    {:password=>:string},
  ]

  api_method :getRecentPosts, :returns => [[Blog::Post]], :expects => [
    {:blogid=>:string},
    {:username=>:string},
    {:password=>:string},
    {:numberOfPosts=>:int},
  ]
end
