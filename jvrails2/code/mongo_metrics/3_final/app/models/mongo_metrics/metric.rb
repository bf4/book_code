#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module MongoMetrics
  class Metric
    include Mongoid::Document

    field :name, type: String
    field :duration, type: Integer
    field :instrumenter_id, type: String
    field :payload, type: Hash
    field :started_at, type: DateTime
    field :created_at, type: DateTime

    def self.store!(args)
      metric = new
      metric.parse(args)
      metric.save!
    end

    require "csv"
    def to_csv
      [name, started_at, duration, instrumenter_id, created_at].to_csv
    end

    def parse(args)
      self.name            = args[0]
      self.started_at      = args[1]
      self.duration        = (args[2] - args[1]) * 1000000
      self.instrumenter_id = args[3]
      self.payload         = args[4]
      self.created_at      = Time.now.utc
    end
  end
end
