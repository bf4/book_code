#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord

  # Statement cache is used to cache a single statement in order to avoid creating the AST again.
  # Initializing the cache is done by passing the statement in the initialization block:
  #
  #   cache = ActiveRecord::StatementCache.new do
  #     Book.where(name: "my book").limit(100)
  #   end
  #
  # The cached statement is executed by using the +execute+ method:
  #
  #   cache.execute
  #
  # The relation returned by the block is cached, and for each +execute+ call the cached relation gets duped.
  # Database is queried when +to_a+ is called on the relation.
  class StatementCache
    def initialize
      @relation = yield
      raise ArgumentError.new("Statement cannot be nil") if @relation.nil?
    end

    def execute
      @relation.dup.to_a
    end
  end
end
