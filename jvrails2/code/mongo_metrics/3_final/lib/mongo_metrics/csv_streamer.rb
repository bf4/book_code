#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module MongoMetrics
  ActionController::Renderers.add :csv do |model, options|
    headers = self.response.headers
    headers["Content-Disposition"] =
      %(attachment; filename="#{controller_name}.csv")
    headers["Cache-Control"] = "no-cache"
    headers.delete "Content-Length"
    self.content_type ||= Mime::CSV
    self.response_body  = CSVStreamer.new(model)
  end
  class CSVStreamer
    def initialize(scope)
      @scope = scope
    end
    def each
      @scope.each do |record|
        yield record.to_csv
      end
    end
  end
end
