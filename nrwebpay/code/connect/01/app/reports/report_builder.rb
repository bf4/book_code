#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---

# Inspired by the the ActiveAdmin::CSV builder class defined at
# https://github.com/activeadmin/activeadmin
# The ActiveAdmin code is Copyright (c) Greg Bell, VersaPay Corporation

class ReportBuilder

  attr_reader :columns, :options
  attr_accessor :humanize_name

  def initialize(options = {}, &block)
    @columns = []
    @options = options
    @block = block
    @humanize_names = options.delete(:humanize_name)
  end

  def csv_options
    @csv_options ||= options.except(
        :encoding_options, :byte_order_mark, :column_names)
  end

  def column(name, _options = {}, &block)
    @columns << Column.new(name, {humanize_name: humanize_name}, block)
  end

  def build(collection = [], output: nil, format: nil)
    exec_columns
    builder = case format
              when :csv
                CsvBuilder.new(columns, options, collection, output || "")
              else
                Builder.new(columns, options, collection, output || [])
              end
    builder.build
  end

  def exec_columns
    @columns = []
    instance_exec(&@block) if @block.present?
    columns
  end


  class Builder

    attr_accessor :collection, :output, :columns, :options

    def initialize(columns, options, collection, output)
      @columns = columns
      @options = options
      @collection = collection
      @output = output
    end

    def build
      build_header
      build_rows
      output
    end

    def build_header
      nil
    end

    def build_rows
      collection.each do |resource|
        output << build_row(resource)
      end
    end

    def build_row(resource)
      result = {}
      columns.each do |column|
        result[column.name] = encode(column.value(resource), options)
      end
      result
    end

    def encode(content, options)
      if options[:encoding]
        content.to_s.encode(options[:encoding], options[:encoding_options])
      else
        content
      end
    end

  end

  class CsvBuilder < Builder

    def add_byte_order_mark
      bom = options.fetch(:byte_order_mark, false)
      output << bom if bom
    end

    def build_header
      add_byte_order_mark
      return unless options.fetch(:column_names, true)
      headers = columns.map { |column| encode(column.name, options) }
      output << CSV.generate_line(headers, options)
    end

    def build_rows
      collection.each do |resource|
        row = build_row(resource)
        output << CSV.generate_line(row.values, options)
      end
    end

  end

  class Column

    attr_reader :name, :data, :options

    def initialize(name, options = {}, block = nil)
      @options = options
      options[:humanize_name] = true if options[:humanize_name].nil?
      @name = humanize_name(name, @options[:humanize_name])
      @data = block || name.to_sym
    end

    def humanize_name(name, humanize_name_option)
      if humanize_name_option
        name.to_s.humanize
      else
        name.to_s
      end
    end

    def value(resource)
      case data
      when Symbol, String then resource.send(data)
      when Proc then resource.instance_exec(resource, &data)
      end
    end

  end

end
