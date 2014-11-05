#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module MongoMetrics
  class MetricsController < ApplicationController
    respond_to :html, :json

    def index
      @metrics = Metric.all
      respond_with(@metrics)
    end

    def destroy
      @metric = Metric.find(params[:id])
      @metric.destroy
      respond_with(@metric)
    end
  end
end
