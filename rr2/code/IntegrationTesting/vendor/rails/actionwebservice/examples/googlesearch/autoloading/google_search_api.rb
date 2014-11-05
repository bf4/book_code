#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class DirectoryCategory < ActionWebService::Struct
  member :fullViewableName, :string
  member :specialEncoding,  :string
end

class ResultElement < ActionWebService::Struct
  member :summary,                   :string
  member :URL,                       :string
  member :snippet,                   :string
  member :title,                     :string
  member :cachedSize,                :string
  member :relatedInformationPresent, :bool
  member :hostName,                  :string
  member :directoryCategory,         DirectoryCategory
  member :directoryTitle,            :string
end

class GoogleSearchResult < ActionWebService::Struct
  member :documentFiltering,          :bool
  member :searchComments,             :string
  member :estimatedTotalResultsCount, :int
  member :estimateIsExact,            :bool
  member :resultElements,             [ResultElement]
  member :searchQuery,                :string
  member :startIndex,                 :int
  member :endIndex,                   :int
  member :searchTips,                 :string
  member :directoryCategories,        [DirectoryCategory]
  member :searchTime,                 :float
end

class GoogleSearchAPI < ActionWebService::API::Base
  inflect_names false

  api_method :doGetCachedPage,         :returns => [:string], :expects => [{:key=>:string}, {:url=>:string}]
  api_method :doGetSpellingSuggestion, :returns => [:string], :expects => [{:key=>:string}, {:phrase=>:string}]

  api_method :doGoogleSearch, :returns => [GoogleSearchResult], :expects => [
    {:key=>:string},
    {:q=>:string},
    {:start=>:int},
    {:maxResults=>:int},
    {:filter=>:bool},
    {:restrict=>:string},
    {:safeSearch=>:bool},
    {:lr=>:string},
    {:ie=>:string},
    {:oe=>:string}
  ]
end
