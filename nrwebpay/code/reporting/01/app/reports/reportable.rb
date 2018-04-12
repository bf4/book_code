#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
module Reportable

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    attr_accessor :report_builder

    def columns(options = {}, &block)
      self.report_builder = ReportBuilder.new(options, &block)
    end

    def to_csv(collection: nil)
      report_builder.build(collection || find_collection,
          output: "", format: :csv)
    end

    def to_json(collection: nil)
      result = report_builder.build(collection || find_collection)
      result.to_json
    end

    def to_csv_enumerator(collection: nil)
      Enumerator.new do |y|
        report_builder.build(collection || find_collection,
            output: y, format: :csv)
      end
    end

  end

end
