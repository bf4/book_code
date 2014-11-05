#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# This class models a vertex in a directed graph.
class Vertex < ActiveRecord::Base
  has_many :sink_edges, :class_name => 'Edge', :foreign_key => 'source_id'
  has_many :sinks, :through => :sink_edges

  has_and_belongs_to_many :sources,
    :class_name => 'Vertex', :join_table => 'edges',
    :foreign_key => 'sink_id', :association_foreign_key => 'source_id'
end
